class Event < ActiveRecord::Base
	require './lib/tasks/googleCal'

	def self.initialSave(user)
		CalendarClass.new.initial_save(user)
	end

end
