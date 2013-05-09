class Crush < ActiveRecord::Base
  attr_accessible :amount, :message
  belongs_to :user
end
