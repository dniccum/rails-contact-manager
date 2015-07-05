class User < ActiveRecord::Base
    has_secure_password

    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :email, uniqueness: true, presence: true, length: { maximum: 50 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    validates :password, length: 6..20

    has_many :contacts
end
