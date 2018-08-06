class Engagement < ApplicationRecord
  belongs_to :listing, optional: true
  belongs_to :business, optional: true
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'Account'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'Account'

  has_many :messages, dependent: :destroy

  after_create :create_inverse, unless: :has_inverse?

  # validates_uniqueness_of :sender_id, :scope => :recipient_id

  # Ensure that there is only ever one unique
  # engagement between a sender and a recipient
  scope :between, -> (sender_id, recipient_id) do
    where("(engagements.sender_id = ? AND engagements.recipient_id = ?) OR (engagements.sender_id = ? AND engagements.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
  end

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverse_match_options
    # { matched_user_id: user_id, user_id: matched_user_id }
    { recipient_id:  sender_id, sender_id: recipient_id, listing_id: listing_id}
  end

  def self.inversed(account_id, listing_id)  
    where(recipient_id: account_id, listing_id: listing_id).first
  end
end
