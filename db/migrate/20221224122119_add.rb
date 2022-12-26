class Add < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :store, null: true, foreign_key: true ,foreign_key: {on_delete: :cascade}
  end
end
