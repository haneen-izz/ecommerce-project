class AddproductToOrder < ActiveRecord::Migration[7.0]
  def change
   
    add_reference :orders, :product, null: true, foreign_key: true ,  :foreign_key => { :on_update => :cascade ,:on_delete => :cascade }

  end
end
