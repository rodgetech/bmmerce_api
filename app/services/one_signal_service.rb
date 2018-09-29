require 'httparty'

class OneSignalService
  API_URL = 'https://onesignal.com/api/v1/notifications'
  APP_ID = '6e1f4645-71e3-469e-838a-16d2a3fdd1b1'
  HEADERS = { 
    "Authorization" => "Basic YmVhMjg0NDYtMjZkMi00YjQyLWFlZGUtYmE4ZmIyYjg5ZTMy", 
    "Content-Type" => "application/json" 
  }

  @body =  {
    "app_id" => APP_ID
  }

  def initialize(record)
    @record = record
  end

  def send_notification(body)
    HTTParty.post(
      API_URL, 
      headers: HEADERS, 
      body: body
    )
  end

  def new_message_notification
     notification_body = { 
       "app_id" => APP_ID,
       "include_player_ids" => [@record.recipient.player_id],
       "contents" => { "en" => "#{@record.body}" },
       "headings" => {"en" => "New message from #{@record.account.name}"},
     }.to_json
     send_notification(notification_body)
  end

  # New crime reported
  def new_report
    player_ids = @record.report_subscribers.where.not(player_id: @record.player_id).pluck(:player_id)
    notification_body = { 
      "app_id" => APP_ID,
      "include_player_ids" => player_ids,
      "contents" => { "en" => "#{@record.details}" },
      "headings" => {"en" => "New crime reported in #{@record.address}"},
    }.to_json
    send_notification(notification_body)
  end

  # New crime report comment
  # Notify all subscribers except the person commenting
  # Notify the person who reported the crime
  def new_comment(excluded_player_id)
    # Notify all subscribers except the person commenting and the crime reporter
    player_ids = @record.report.report_subscribers.where.not(player_id: excluded_player_id, is_reporter: true).pluck(:player_id)
    # player_ids = @record.report.report_subscribers.pluck(:player_id)
    puts "PLAYER IDS"
    puts player_ids
    notification_body = { 
      "app_id" => APP_ID,
      "include_player_ids" => player_ids,
      "contents" => { "en" => "#{@record.body}" },
      "headings" => {"en" => "Someone commented on a crime report you are subscribed to"},
    }.to_json
    send_notification(notification_body)

    return if excluded_player_id == @record.report.report_subscribers.where(is_reporter: true).first.player_id

    # Notify just the crime reporter
    reporter_id = @record.report.report_subscribers.where(is_reporter: true).pluck(:player_id)
    puts "REPORTER ID"
    puts reporter_id
    notification_body = { 
      "app_id" => APP_ID,
      "include_player_ids" => reporter_id,
      "contents" => { "en" => "#{@record.body}" },
      "headings" => {"en" => "Someone commented on your crime report"},
    }.to_json
    send_notification(notification_body)
  end
end