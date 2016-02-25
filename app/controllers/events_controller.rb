class EventsController < ApplicationController

  before_filter :authorize

  require './app/classes/charts'
  require './app/classes/math'
  require './app/classes/chartArray'
  require './app/classes/stats'
  
  def new
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
  end

  def analyze
    @events = Event.where(user_id: current_user.id)

    # Develop lienar regression formula in seperate class
    @linear_regress_attendee_rating = SimpsonMathClass.new.linearRegression(current_user, :attendee_count, :rating)
    @linear_regress_hourly_rating = SimpsonMathClass.new.linearRegression(current_user, :start, :rating)
    @linear_regress_recurrence_rating = SimpsonMathClass.new.linearRegression(current_user, :recurrence, :rating)
    
    # Develop arrays for charts in seperate class
    events_ratings_hourly_array = ChartArray.new.dateTimeHourArray(:start, current_user)
    events_ratings_attendees_array = ChartArray.new.numberArray(:attendee_count, current_user)
    events_ratings_recurrence_array = ChartArray.new.categoricalArray(:recurrence, current_user)
    
    # Build charts in seperate class
    @events_ratings_hourly = GoogleChart.new.scatterRatingsChart(events_ratings_hourly_array, "Hour of Day", 0, 23, "Ratings vs. Hour of Day Comparison (#{@linear_regress_hourly_rating[:line]})")
    @events_ratings_attendees = GoogleChart.new.scatterRatingsChart(events_ratings_attendees_array, "No. of Attendees", 0, 25, "Ratings vs. No. of Attendees (#{@linear_regress_attendee_rating[:line]})")
    @events_ratings_recurrence = GoogleChart.new.bubbleRatingsChart(events_ratings_recurrence_array, "Recurring Meeting (0 = No)", 0, 1, "Ratings vs. Recurring meeting (#{@linear_regress_recurrence_rating[:line]})")
  end

  def ratings
    if !Event.where(user_id: current_user.id).empty?
      @events_rated = Event.where(user_id: current_user.id).where.not(rating: nil).count
      @events = Event.where(user_id: current_user.id).where.not(start: nil).where("start < ?", DateTime.now).where.not(status: 'cancelled').where.not(attendee_count: 0).where.not(attendee_count: 1).where.not(summary: "%DNS").where.not(summary: "%OOO").order('start desc')
    else
      redirect_to '/settings'
    end
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

  def search
    
  end

  def logreg
    # x = Stats.new.logit(current_user)
    one = Event.where(user_id: current_user.id).where(rating: 1).to_a.map(&:serializable_hash)
    five = Event.where(user_id: current_user.id).where(rating: 5).to_a.map(&:serializable_hash)
    other = Event.where(user_id: current_user.id).where(rating: nil).to_a.map(&:serializable_hash)
    classifier = ClassifierReborn::Bayes.new 'One', 'Five'
    classifier.train_five five.join(" ")
    classifier.train_one one.join(" ")
    other.each do |o|
      puts classifier.classify o.to_s
    end
  end

  def edit
  end

  def destroy
  end

  def create
    Event.delay.sync(current_user)
    flash[:notice] = "Currently syncing..."
    redirect_to '/settings'
  end
end
