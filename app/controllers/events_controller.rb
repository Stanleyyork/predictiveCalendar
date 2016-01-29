class EventsController < ApplicationController

  before_filter :authorize
  require './app/classes/charts'
  
  def new
  end

  def show
    @event = Event.find(params[:id])
    @attendees = Attendee.where(gcal_event_id: @event.gcal_event_id)
  end

  def index
    @events = Event.where(user_id: current_user.id)
    events_ratings_hourly_array = Event.where(user_id: current_user.id).where("status != ?", 'cancelled').where.not(rating: nil).where.not(start: nil).map{|e|[e.start.in_time_zone("Pacific Time (US & Canada)").hour, e.rating]}.group_by{|e|e}.map{|k,v|[" ",k[0],k[1],v.count]}
    @events_ratings_hourly = GoogleChart.new.scatterRatingsChart(events_ratings_hourly_array, "Hour of Day")
  end

  def ratings
    @events_rated = Event.where(user_id: current_user.id).where.not(rating: nil).count
    @events = Event.where(user_id: current_user.id).where("status != ?", 'cancelled').where("summary NOT LIKE ?", "%OOO").where("summary NOT LIKE ?", "%DNS").order('start desc')
  end

  def update_ratings
    ratings_hash = params[:ratings]
    ratings_hash.each do |r|
      e = Event.find_by_gcal_event_id(r[1][0])
      e.rating = r[1][1]
      e.save
    end
    render :json => { :Success => ratings_hash }
  end

  def update
    
  end

  def edit
  end

  def destroy
  end

  def create
    Event.delay.sync(current_user)
    redirect_to '/events'
  end
end
