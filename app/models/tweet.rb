class Tweet < ApplicationRecord
    # A tweet belongs to a user
    belongs_to :user

    # validations
    validates :user_id, presence: true
    validates :message, presence: true, length: { maximum: 140 }
end
