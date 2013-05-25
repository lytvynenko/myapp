class Profile < ActiveRecord::Base
  belongs_to :User
  attr_accessible :firstname, :lastname, :primary_email, :primary_mobile
end
