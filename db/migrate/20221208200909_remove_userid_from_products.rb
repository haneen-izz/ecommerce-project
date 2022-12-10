class RemoveUseridFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :user_id
  end
end
