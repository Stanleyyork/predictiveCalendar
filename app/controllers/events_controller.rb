class EventsController < ApplicationController

  before_filter :authorize
  
  def new
  end

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def update
    
  end

  def edit
  end

  def destroy
  end

  def create
    Event.delay.initialSave(current_user)
    redirect_to '/events'
  end
end
