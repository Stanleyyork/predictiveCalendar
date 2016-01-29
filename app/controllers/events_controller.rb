class EventsController < ApplicationController

  before_filter :authorize
  require './app/classes/charts'
  
  def new
  end

  def index
    @events = Event.where(user_id: current_user.id)
    @events_count_cancelled = Event.where(user_id: current_user.id).where(status: 'cancelled').count
    @events_hourly = Event.where(user_id: current_user.id).where("status != ?", 'cancelled').group_by_hour_of_day(:start, time_zone: "Pacific Time (US & Canada)").count
    @events_week_day = Event.where(user_id: current_user.id).where("status != ?", 'cancelled').group_by_day_of_week(:start, time_zone: "Pacific Time (US & Canada)").count
    @events_hourly_array = @events_hourly.map{|k,v| k < 12 ? ["#{k}am",v] : ["#{k}pm",v]}
    @events_hourly = GoogleChart.new.eventsHourly(@events_hourly_array)
    @cancelled_percentage = GoogleChart.new.cancelledPieChart(@events_count_cancelled, @events.count)
  end

  def ratings
    @events = Event.where(user_id: current_user.id).where("status != ?", 'cancelled').where("summary NOT LIKE ?", "%OOO").where("summary NOT LIKE ?", "%DNS").order('start desc')
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
