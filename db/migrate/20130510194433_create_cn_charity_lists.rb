class CreateCnCharityLists < ActiveRecord::Migration
  def change
    create_table :cn_charity_lists do |t|
      t.integer :listid
      t.string :listname
      t.integer :typeid
      t.string :list_type
      t.string :rank
      t.integer :orgid
      t.string :charity_name

      t.timestamps
    end
  end
end
