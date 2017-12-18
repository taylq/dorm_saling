class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :seller_id
      t.decimal :price
      t.string :picture
      t.integer :category_id
      t.time :begin_at
      t.time :finish_at
      t.boolean :auto_close, default: false

      t.timestamps
    end
  end
end
