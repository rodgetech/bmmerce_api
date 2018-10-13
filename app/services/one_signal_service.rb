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
    result = HTTParty.post(
      API_URL, 
      headers: HEADERS, 
      body: body
    )
  end

  def new_message_notification
    notification_body = { 
      "app_id" => APP_ID,
      # "include_player_ids" => [@record.recipient.player_id],
      "contents" => { "en" => "#{@record.body}" },
      "headings" => {"en" => "New message from #{@record.account.name}"},
      "filters" => [
        {"field": "tag", "key": "userId", "relation": "=", "value": "#{@record.recipient.id}"}, 
      ]
    }.to_json
    send_notification(notification_body)
  end

  def new_listing_notification
    # player_ids = Account.where.not(id: @record.account.id).near([@record.latitude, @record.longitude], 25).each.pluck(:player_id)
    Account.where.not(id: @record.account.id).near([@record.latitude, @record.longitude], 15).find_each do |account|
      notification_body = { 
        "app_id" => APP_ID,
        # "include_player_ids" => player_ids,
        "contents" => { "en" => "#{@record.title}" },
        "headings" => {"en" => "New item posted near you"},
        "big_picture" => @record.images.first.listing_image.url,
        "data" => {"listingId": "#{@record.id}"},
        "filters" => [
          {"field": "tag", "key": "userId", "relation": "=", "value": "#{account.id}"}, 
        ]
      }.to_json
      send_notification(notification_body)
    end
  end

end