class NewListingNotificationWorker
  include Sidekiq::Worker

  def perform(listing_id)
    listing = Listing.find(listing_id)
    OneSignalService.new(listing).new_listing_notification
  end
end
