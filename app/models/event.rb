class Event < ActiveRecord::Base
	require './lib/tasks/googleCal'

	belongs_to :user
	belongs_to :calendar
	has_and_belongs_to_many :attendees

	def self.sync(user)
		CalendarClass.new.sync(user)
	end

	def self.load_data_from_database(user)
	  records = []
	  Event.where(user_id: user.id).where(algolia: nil).each do |e|
	  	record = {
	  		"objectID": e.id,
	  		"user_id": e.user_id,
	  		"creator": e.creator,
	  		"organizer": e.organizer,
	  		"description": e.description,
	  		"gcal_event_id": e.gcal_event_id,
	  		"original_start_time": e.original_start_time,
	  		"start": e.start,
	  		"recurrence": e.recurrence,
	  		"summary": e.summary,
	  		"rating": e.rating,
	  		"attendee_count": e.attendee_count
	  	}
	  	e.algolia = true
	  	e.save
	  	records.push(record)
	  end
	  return records
	end

	def self.load_algolia(user)
		Algolia.init :application_id => ENV.fetch('ALGOLIA_APPLICATION_ID'), :api_key => ENV.fetch('ALGOLIA_API_KEY')
		index = Algolia::Index.new(ENV.fetch('ALGOLIA_ENV'))
		index.set_settings({
		  :attributesToIndex => ["creator", "organizer", "description", "original_start_time", "start", "summary", "rating", "attendee_count"]
		})
		Event.load_data_from_database(user).each_slice(1000) do |batch|
		  index.add_objects(batch)
		end
	end

end