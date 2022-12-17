class OrderDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Order.id", cond: :eq },
      user_id: { source: "Order.user_id"},
      product_id: { source: "Order.product_id"},
      email: { source: "Order.user.email"},
      quantity: { source: "Order.quantity"},
      price: { source: "Order.price"},
      store_name: { source: "Order.product.store.name"},
      created_at: { source: "Order.created_at"},
    }
  end

  def data
    records.map do |record|
      {
        # example:
        id: record.id,
        user_id: record.user_id,
        product_id: record.product_id,
        email: record.user.email,
        quantity: record.quantity,
        price: record.price,
        store_name:  record.product.store.name,
        created_at: record.created_at.strftime("%m/%d/%Y")
      }
    end
  end

  def get_raw_records
    # insert query here
    Order.joins(:product).where(product: { user_id: options[:current_user].id })
  end
end
