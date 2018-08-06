class Message < ApplicationRecord
  belongs_to :engagement
  belongs_to :account

  # after_create :create_inverse

  validates_presence_of :body, :engagement_id, :account_id

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def inverse_match_options
    # { matched_user_id: user_id, user_id: matched_user_id }
    { body: body, account_id: account_id, engagement_id: inversed_engagement.id}
  end

  # Assign message copy to the related inversed engagement
  def inversed_engagement
    Engagement.where(recipient_id: account_id, listing_id: engagement.listing_id).first
  end
end
