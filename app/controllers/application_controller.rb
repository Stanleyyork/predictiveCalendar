class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require './app/classes/charts'

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def homepage
    render template: "layouts/homepage.html.erb"
  end

  def about

    @user = User.find_by_email("erinroselarsen@gmail.com")
    attendees = [100, 90, 55, 50, 30, 25, 25, 20, 20, 18, 15, 12]
    events_collabs_array = attendees.each_with_index.map{|x,i| ["Stanley", "J. Harbaugh-#{i}", x]}
    @events_collabs_sankey_small = GoogleChart.new.sankey(events_collabs_array[1..15],400,325)
    @events_collabs_sankey_med = GoogleChart.new.sankey(events_collabs_array[1..15],200,650)

    @events_hourly_grouped = Event.where(user_id: @user.id).group_by_hour_of_day(:start, time_zone: "Pacific Time (US & Canada)").count
    @events_hourly_array = @events_hourly_grouped.map{|k,v| k < 12 ? ["#{k}a",v] : k == 12 ? ["#{k}p",v] : ["#{k-12}p",v]}
    @events_hourly = GoogleChart.new.eventsHourly(@events_hourly_array.map{|k,v| v != 0 ? [k,v] : []}, 150, 700, '#ffffff')
    @events_hourly_small = GoogleChart.new.eventsHourly(@events_hourly_array.map{|k,v| v != 0 ? [k,v] : []}, 150, 650, '#ffffff')

    render template: "layouts/about.html.erb"
  end
  
end
