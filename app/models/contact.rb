class Contact < ActiveRecord::Base
    belongs_to :user

    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 50 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    validates :company, length: { maximum: 50 }

    scope :allContacts, lambda { |user|
        where(:user_id => "#{user}")
    }
    scope :byLastName, lambda { order("contacts.last_name ASC") }
    scope :byFirstName, lambda { order("contacts.first_name ASC") }
    scope :byCompany, lambda { order("contacts.company ASC") }
    scope :search, lambda { |query|
        where(["first_name like ?", "%#{query}%"])
    }
end
