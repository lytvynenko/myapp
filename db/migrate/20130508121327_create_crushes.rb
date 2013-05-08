class CreateCrushes < ActiveRecord::Migration
  def change
    create_table :crushes do |t|
      t.integer :user_id
      t.float :amount
      t.string :message

      t.timestamps
    end
  end
end
