class Calendar < ActiveRecord::Base
	require './lib/tasks/googleCal'

	def self.calCall
		CalendarClass.new.apiCall()
	end

end
