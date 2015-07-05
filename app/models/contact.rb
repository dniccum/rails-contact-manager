class Contact < ActiveRecord::Base
    belongs_to :user

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
