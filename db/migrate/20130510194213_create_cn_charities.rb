class CreateCnCharities < ActiveRecord::Migration
  def change
    create_table :cn_charities do |t|
      t.integer :orgid
      t.string :charity_name
      t.string :city
      t.string :state
      t.string :category
      t.string :cause
      t.string :tag_line
      t.string :ein
      t.float :overallrtg
      t.float :overallscore
      t.integer :rank
      t.boolean :featured

      t.timestamps
    end
  end
end
