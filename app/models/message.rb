class Message < ApplicationRecord
  belongs_to :engagement
  belongs_to :account
end
