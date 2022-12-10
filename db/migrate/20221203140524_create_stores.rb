class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
