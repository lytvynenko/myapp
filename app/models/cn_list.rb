class CnList < ActiveRecord::Base
  attr_accessible :description, :list_type, :listid, :listname, :typeid, :show, :show_order,:resource_uri
end
