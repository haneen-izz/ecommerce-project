class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :product, null: false, foreign_key: true, foreign_key: {on_delete: :cascade}
      t.integer :quantity
      t.float :price
      t.integer :guest_id

      t.string :product_name
      t.timestamps
    end
  end
end
