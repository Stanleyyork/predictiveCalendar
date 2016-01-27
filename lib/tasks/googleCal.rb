require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class CalendarClass

  def apiCall()
    oOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    aPPLICATION_NAME = 'Google Calendar API Ruby Quickstart'
    cLIENT_SECRETS_PATH = './lib/tasks/client_secret.json'
    cREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                                 "calendar-ruby-quickstart.yaml")
    sCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY
    #OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    
    # Initialize the API
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = aPPLICATION_NAME
    service.authorization = authorize(oOB_URI, sCOPE, cREDENTIALS_PATH, cLIENT_SECRETS_PATH)

    return service
  end

  def authorize(oOB_URI, sCOPE, cREDENTIALS_PATH, cLIENT_SECRETS_PATH)
    puts "hello"
    FileUtils.mkdir_p(File.dirname(cREDENTIALS_PATH))
    client_id = Google::Auth::ClientId.from_file(cLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: cREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, sCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: oOB_URI)
      puts "inside not authorized"
      return "url: #{url}"
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: oOB_URI)
    end
    return credentials
  end

end

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