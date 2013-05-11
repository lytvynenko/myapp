class AddColumnsToCnCharityLists < ActiveRecord::Migration
  def change
    add_column :cn_charity_lists, :category, :string
    add_column :cn_charity_lists, :charity_url, :string
    add_column :cn_charity_lists, :category_slug, :string
    add_column :cn_charity_lists, :value_label, :string
    add_column :cn_charity_lists, :resource_uri, :string
    add_column :cn_charity_lists, :value, :string
    add_column :cn_charity_lists, :ein, :string
  end
end
