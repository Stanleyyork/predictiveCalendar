class EventsController < ApplicationController
  
  def new
  end

  def index
  end

  def update
    
  end

  def edit
  end

  def destroy
  end

  def create
    Event.initialSave(current_user)
    redirect_to '/profile'
  end
end
