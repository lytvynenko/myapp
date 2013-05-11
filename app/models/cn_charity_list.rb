class CnCharityList < ActiveRecord::Base
  attr_accessible :charity_name, :list_type, :listid, :listname, :orgid, :rank, :typeid
  attr_accessible :category, :charity_url, :category_slug, :value_label, :resource_uri, :value, :ein
end
