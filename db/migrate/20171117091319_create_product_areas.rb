class CreateProductAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :product_areas do |t|
      t.integer :product_id
      t.integer :area_id

      t.timestamps
    end
  end
end
