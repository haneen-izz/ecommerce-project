class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true, foreign_key: {on_delete: :cascade}
      t.references :product, null: false, foreign_key: true, foreign_key: {on_delete: :cascade}
      t.integer :quantity
      t.float :price
      t.float :total_price
      t.string :product_name
      t.timestamps
    end
  end
end
