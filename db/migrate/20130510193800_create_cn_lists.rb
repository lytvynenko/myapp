class CreateCnLists < ActiveRecord::Migration
  def change
    create_table :cn_lists do |t|
      t.integer :listid
      t.string :listname
      t.string :description
      t.integer :typeid
      t.string :list_type
      t.boolean :show
      t.integer :order

      t.timestamps
    end
  end
end
