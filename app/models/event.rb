class Event < ActiveRecord::Base
	require './lib/tasks/googleCal'

	has_many :attendees

	#[:attachments, :anyone_can_add_self, :created, :creator, :description, :end, :guests_can_invite_others, :guests_can_see_other_guests, :location, :organizer, :original_start_time, :recurrence, :start, :status, :summary, :updated, :visibility, :creator_self, :organizer_email, :organizer_self, :attendee_count],

	def self.sync(user)
		CalendarClass.new.sync(user)
	end

end
