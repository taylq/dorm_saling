class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :room
      t.integer :phone
      t.integer :position
      t.integer :area_id

      t.timestamps
    end
  end
end
