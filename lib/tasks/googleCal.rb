require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class CalendarClass

  ## nextPageToken = Token used to access the next page of this result. Omitted
  #  if no further results are available, in which case nextSyncToken is provided.

  ## nextSyncToken = Token used at a later point in time to retrieve only the entries
  #  that have changed since this result was returned. Omitted if further results are
  #  available, in which case nextPageToken is provided.

  def sync(user, page_token='')
    @user = user
    token = Calendar.where(user_id: @user.id).last.code
    last_cal = Calendar.where(user_id: @user.id).last
    client = Signet::OAuth2::Client.new(access_token: token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    if(last_cal.next_sync_token)
      puts "sync token"
      puts "#{last_cal.next_sync_token}"
      events_array = service.list_events('primary', max_results: 2500, sync_token: last_cal.next_sync_token)
    elsif(page_token == '')
      puts "no page token"
      events_array = service.list_events('primary', max_results: 2500)
    else
      puts "page token"
      events_array = service.list_events('primary', max_results: 2500, page_token: page_token)
    end
    
    if(events_array.items.empty?)
      return "No calendar events to sync."
    else
      parseAndSave(events_array, user, last_cal)
    end

    if(events_array.next_page_token)
      initial_save(user, events_array.next_page_token)
    else
      last_cal.next_sync_token = events_array.next_sync_token
      last_cal.save
    end
  end

  def parseAndSave(events_array, user, last_cal)
    events_array.items.each do |e|
      existEvent = Event.find_by_gcal_event_id(e.id)
      event_attributes = {
        user_id: user.id,
        calendar_id: last_cal.id,
        attachments: e.attachments,
        anyone_can_add_self: e.anyone_can_add_self,
        syncd_and_changed: !existEvent.nil?,
        round: existEvent.nil? ? 1 : existEvent.round + 1,
        created: e.created,
        creator: e.creator.try(:display_name),
        creator_self: e.creator.try(:self),
        description: e.description,
        end: e.end.try(:date),
        html_link: e.html_link,
        guests_can_invite_others: e.guests_can_invite_others,
        guests_can_see_other_guests: e.guests_can_see_other_guests,
        gcal_event_id: e.id,
        location: e.location,
        organizer_name: e.organizer.try(:display_name),
        organizer_email: e.organizer.try(:email),
        organizer_self: e.organizer.try(:self),
        original_start_time: e.original_start_time.try(:date_time),
        recurrence: e.recurrence,
        recurring_event_id: e.recurring_event_id,
        reminders: e.reminders.hash.to_s,
        start: e.start.try(:date_time),
        status: e.status,
        summary: e.summary,
        updated: e.updated,
        visibility: e.visibility
      }

      event = Event.new()
      event.update_attributes(event_attributes)
      event.save
      if !e.attendees.nil?
        e.attendees.each do |a|
          a = Attendee.new(a.to_h)
          a.round = existEvent.nil? ? 1 : existEvent.round + 1
          a.event_id = e.id
          a.save
        end
      end
    end
  end

end

#
#     t.integer  "user_id"
#     t.integer  "attendees_id"
#     t.boolean  "attachments"
#     t.boolean  "anyone_can_add_self"
#     t.datetime "created"
#     t.string   "creator"
#     t.string   "description"
#     t.datetime "end"
#     t.boolean  "guests_can_invite_others"
#     t.boolean  "guests_can_see_other_guests"
#     t.integer  "gcal_event_id"
#     t.string   "location"
#     t.string   "organizer"
#     t.datetime "original_start_time"
#     t.boolean  "recurrence"
#     t.integer  "recurring_event_id"
#     t.string   "reminders"
#     t.datetime "start"
#     t.string   "status"
#     t.string   "summary"
#     t.datetime "updated"
#     t.string   "visibility"
#     t.datetime "created_at",                  null: false
#     t.datetime "updated_at",

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