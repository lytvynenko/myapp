class CreateFeaturedCharities < ActiveRecord::Migration
  def change
    create_table :featured_charities do |t|
      t.string :name
      t.string :address
      t.string :ein
      t.string :fg_uuid
      t.integer :cn_id
      t.string :image

      t.timestamps
    end
  end
end
