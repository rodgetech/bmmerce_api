class NewMessageNotificationWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    OneSignalService.new(message).new_message_notification
  end
end
