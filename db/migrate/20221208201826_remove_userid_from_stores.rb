class RemoveUseridFromStores < ActiveRecord::Migration[7.0]
  def change
    remove_column :stores, :user_id

  end
end
