require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "calendar-ruby-quickstart.yaml")
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(
    client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(
      base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +
         "resulting code after authorization"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials
end

# Initialize the API
service = Google::Apis::CalendarV3::CalendarService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Fetch the next 10 events for the user
calendar_id = 'primary'
events = service.list_events(calendar_id)

events.items.each do |x|
  puts x.summary
  puts "=="
end

#puts events.items[0]

# puts "Upcoming events:"
# puts "No upcoming events found" if response.items.empty?
# response.items.each do |event|
#   start = event.start.date || event.start.date_time
#   puts "- #{event.summary} (#{start})"
# end

## to_h
# attendees
# attachments
# anyone_can_add_self
# created
# creator
# description
# end
# guests_can_invite_others
# guests_can_see_other_guests
# id
# location
# organizer
# original_start_time
# recurrence
# recurring_event_id
# reminders
# start
# status
# summary
# updated
# visibility


# anyone_can_add_self
# anyone_can_add_self=
# anyone_can_add_self?
# attachments
# attachments=
# attendees
# attendees=
# attendees_omitted
# attendees_omitted=
# attendees_omitted?
# color_id
# color_id=
# created
# created=
# creator
# creator=
# description
# description=
# end
# end=
# end_time_unspecified
# end_time_unspecified=
# end_time_unspecified?
# etag
# etag=
# extended_properties
# extended_properties=
# gadget
# gadget=
# guests_can_invite_others
# guests_can_invite_others=
# guests_can_invite_others?
# guests_can_modify
# guests_can_modify=
# guests_can_modify?
# guests_can_see_other_guests
# guests_can_see_other_guests=
# guests_can_see_other_guests?
# hangout_link
# hangout_link=
# html_link
# html_link=
# i_cal_uid
# i_cal_uid=
# id
# id=
# kind
# kind=
# location
# location=
# locked
# locked=
# locked?
# organizer
# organizer=
# original_start_time
# original_start_time=
# private_copy
# private_copy=
# private_copy?
# recurrence
# recurrence=
# recurring_event_id
# recurring_event_id=
# reminders
# reminders=
# sequence
# sequence=
# source
# source=
# start
# start=
# status
# status=
# summary
# summary=
# transparency
# transparency=
# updated
# updated=
# visibility
# visibility=
# update!
# to_h
# psych_to_yaml
# to_yaml
# to_yaml_properties
# to_json
# pretty_print
# pretty_print_cycle
# pretty_print_instance_variables
# pretty_print_inspect
# nil?