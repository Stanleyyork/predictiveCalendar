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
    last_cal = Calendar.where(user_id: @user.id).last
    token = last_cal.code
    client = Signet::OAuth2::Client.new(access_token: token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    # if(last_cal.next_sync_token)
    #   puts "sync token"
    #   puts "#{last_cal.next_sync_token}"
    #   events_array = service.list_events('primary', max_results: 2500, sync_token: last_cal.next_sync_token)
    # elsif(page_token == '')
    if(page_token == '')
      events_array = service.list_events('primary', max_results: 2500)
    else
      events_array = service.list_events('primary', max_results: 2500, page_token: page_token)
    end
    
    if(events_array.items.empty?)
      return "No calendar events to sync."
    else
      parseAndSave(events_array, user, last_cal)
    end

    if(events_array.next_page_token)
      sync(user, events_array.next_page_token)
    else
      last_cal.next_sync_token = events_array.next_sync_token
      last_cal.save
      user.syncing = false
      user.save
    end
  end

  def parseAndSave(events_array, user, last_cal)
    i = 0
    events_array.items.each do |e|
    puts i
    i += 1
      existEvent = Event.where(user_id: user.id).where(gcal_event_id: e.id).first
      event_attributes = {
        user_id: user.id,
        calendar_id: last_cal.id,
        attachments: e.attachments,
        anyone_can_add_self: e.anyone_can_add_self,
        syncd_and_changed: !existEvent.nil?,
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
        recurrence: e.try(:recurrence).nil? ? false : true,
        recurrence_value: e.try(:recurrence).nil? ? nil : e.recurrence[0],
        recurring_event_id: e.recurring_event_id,
        reminders: e.reminders.hash.to_s,
        start: e.start.try(:date_time),
        status: e.status,
        summary: e.summary,
        updated: e.updated,
        visibility: e.visibility
      }
      if existEvent.nil?
        event = Event.new()
      else
        event = existEvent
        Attendee.where(user_id: user.id).where(event_id: event.id).delete_all
      end
      event.update_attributes(event_attributes)
      event.save
      if !e.attendees.nil?
        event.attendee_count = e.attendees.count
        event.save
        attendeeSave(user, event, e)
      end
    end
  end

  def attendeeSave(user, event, e)
    e.attendees.each do |a|
      a = Attendee.new(a.to_h)
      a.event_id = e.id
      a.user_id = user.id
      a.save
    end
  end

end