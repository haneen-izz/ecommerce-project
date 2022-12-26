class AddproductidToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :product, null: false, foreign_key: true, foreign_key: { on_update: :cascade}
  end
end
