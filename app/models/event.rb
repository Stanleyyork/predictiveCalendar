class Event < ActiveRecord::Base
	require './lib/tasks/googleCal'

	def self.sync(user)
		CalendarClass.new.sync(user)
	end

end
