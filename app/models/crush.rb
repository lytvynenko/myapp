class Crush < ActiveRecord::Base
  attr_accessible :amount, :message, :user_id
end
