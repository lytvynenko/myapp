class CnCharity < ActiveRecord::Base
  attr_accessible :category, :cause, :charity_name, :city, :ein, :orgid, :overallrtg, :overallscore, :rank, :state, :tag_line, :featured
end
