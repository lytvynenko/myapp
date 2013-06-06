class AddDescriptionToCncharitylist < ActiveRecord::Migration
  def change
    add_column :cn_charity_lists, :description, :text
  end
end
