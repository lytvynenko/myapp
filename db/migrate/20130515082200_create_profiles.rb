class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :firstname
      t.string :lastname
      t.string :primary_email
      t.string :primary_mobile

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
