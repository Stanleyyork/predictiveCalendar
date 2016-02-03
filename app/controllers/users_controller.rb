class UsersController < ApplicationController

  require 'signet/oauth_2/client'
  require './app/classes/charts'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  before_filter :authorize, :only => [:redirect, :callback, :edit, :update, :destroy]

  def show
    if params[:username] == 'profile' || !User.find_by_username(params[:username]).nil?
      @user = User.find_by_username(params[:username]) || current_user
      if !Event.where(user_id: @user.id).empty?
        if @user.smart_query == true
          @events = Event.where(user_id: @user.id).where.not(status: 'cancelled').where.not("summary like ?", "%DNS%").where.not("summary like ?", "%OOO")
        else
          @events = Event.where(user_id: @user.id)
        end
        @events_count = @events.count

        # Average Day Statistics
        @average_day_events_count = @events.where("start > ?", Date.today()-90).where("start < ?", Date.today()).count / ((Time.zone.now - @events.where("start > ?", Date.today()-90).where("start < ?", Date.today()).order(:start).first.start)/(3600*24))
        @average_day_events_attendee_count = ((@events.where("start > ?", Date.today()-90).where("start < ?", Date.today()).where.not(attendee_count: nil).pluck(:attendee_count).sum / @events.where("start > ?", Date.today()-90).where("start < ?", Date.today()).where.not(attendee_count: nil).pluck(:attendee_count).count.to_f)-1) * @average_day_events_count
        
        @events_count_recurrence = @events.where(recurrence: true).count
        
        # Queries for charts
        @top_25_attendees = Attendee.where(user_id: @user.id).where.not("email like ?", "%resource.calendar.google.com%").group(:email).order('count_id desc').limit(25).count(:id)
        events_collabs_array = @top_25_attendees.each_with_index.map{|x,i| @user == current_user ? ["#{@user.name}", x[0].split("@").first, x[1]] : ["#{@user.name}", "J. Harbaugh-#{i}", x[1]]}
        @events_count_cancelled = Event.where(user_id: @user.id).where(status: 'cancelled').count
        @events_hourly_grouped = @events.group_by_hour_of_day(:start, time_zone: "Pacific Time (US & Canada)").count
        @events_week_day = @events.group_by_day_of_week(:start, time_zone: "Pacific Time (US & Canada)").count
        @events_morning = @events_hourly_grouped.map{|k,v| k < 12 ? v : 0}
        @events_afternoon = @events_hourly_grouped.map{|k,v| k < 12 ? 0 : v}
        @events_morn_after = @events_morning.sum > @events_afternoon.sum ? "morning" : "afternoon"
        events_daily_array = @events.group_by_day_of_week(:start, time_zone: "Pacific Time (US & Canada)", format: "%A").count.map{|k,v| ["#{k}",v]}
        @meetings_created_self = @events.where( Event.arel_table[:organizer_self].eq(true). or(Event.arel_table[:creator_self].eq(true)) ).count
        @meetings_attended = @events_count - @meetings_created_self
        
        # Percentage of Meetings Cancelled Chart
        @cancelled_percentage = GoogleChart.new.cancelledPieChart(@events_count_cancelled, @events_count)
        
        # Top Time of Day (Hour) Charts
        @events_hourly_array = @events_hourly_grouped.map{|k,v| k < 12 ? ["#{k}am",v] : ["#{k}pm",v]}
        @events_hourly = GoogleChart.new.eventsHourly(@events_hourly_array.map{|k,v| v != 0 ? [k,v] : []}, 150, 1000)
        @events_hourly_med = GoogleChart.new.eventsHourly(@events_hourly_array.map{|k,v| v != 0 ? [k,v] : []}, 150, 850)
        @events_hourly_small = GoogleChart.new.eventsHourly(@events_hourly_array.map{|k,v| v != 0 ? [k,v] : []}, 150, 650)
        
        # Top Collaborator Charts
        @events_collabs_sankey = GoogleChart.new.sankey(events_collabs_array[1..-1])
        @events_collabs_sankey_med = GoogleChart.new.sankey(events_collabs_array[1..15],400,650)
        @events_collabs_sankey_small = GoogleChart.new.sankey(events_collabs_array[1..10],300,375)

        # Top Days Chart
        @events_daily = GoogleChart.new.eventsDaily(events_daily_array[1..5], 225, 500)
      else
        redirect_to '/settings'
      end
    else
      redirect_to '/profile'
    end
  end

  def new
    if current_user
      redirect_to '/settings'
    end
    @user = User.new
  end

  def index
    
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(current_user.id)
    @no_events = Event.where(user_id: @user.id).empty?
  end

  def update
    @user = User.find(current_user.id)
    user_params = params.require(:user).permit(:name,:email,:private_profile,:smart_query)
    if @user.update_attributes(user_params)
      flash[:notice] = "Updated!"
      redirect_to "/settings"
    else 
      flash[:notice] = @user.errors.map{|k,v| "#{k} #{v}".capitalize}
      redirect_to "/settings"
    end
  end

  def destroy
    if @user.id == current_user.id
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to '/signup'
    end
  end

  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: 'http://lunacal.herokuapp.com/oauth2callback'
    })

    redirect_to client.authorization_uri.to_s
  end

  def callback
    @user = current_user
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: url_for(:action => :callback),
      code: params[:code]
    })
    response = client.fetch_access_token!
    if Calendar.find_by_user_id(@user.id).nil?
      c = Calendar.new
      c.user_id = current_user.id
      c.code = response['access_token']
      c.save
    end

    redirect_to '/events/create'
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end
  
end
