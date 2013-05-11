class AddUriToCnlist < ActiveRecord::Migration
  def change
    add_column :cn_lists, :resource_uri, :string
  end
end
