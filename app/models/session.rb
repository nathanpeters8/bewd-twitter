class Session < ApplicationRecord
    # A session belongs to a user
    belongs_to :user

    # A session has a token
    validates :user_id, presence: true

    # generate a token before validation
    before_validation :generate_token

    # generate a url safe token
    private

    def generate_token
        self.token = SecureRandom.urlsafe_base64
    end
end
