class User < ApplicationRecord
    # A user has many sessions and tweets
    has_many :sessions
    has_many :tweets

    # validations
    validates :username, presence: true, length: {minimum: 3, maximum: 64}, uniqueness: true
    validates :password, presence: true, length: {minimum: 8, maximum: 64}
    validates :email, presence: true, length: {minimum: 5, maximum: 500}, uniqueness: true

    # hash password before saving
    before_create :hash_password

    private

    def hash_password
        self.password = BCrypt::Password.create(self.password)
    end

end
