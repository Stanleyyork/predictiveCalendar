class EventsController < ApplicationController
  def new
  end

  def index
    @events = Calendar.calCall.list_events('primary')
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def create
  end
end
