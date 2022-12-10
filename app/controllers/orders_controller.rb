class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :destroy,:edit,:update]

	def new 
		@order = Order.new    
	end
	def create 
		@order = Order.new(order_params)
		if @order.save 
           redirect_to orders_path
		end
	end
	def index 
		@orders = Order.all
	end 
	def show 
		@order = Order.find(params[:id])
	end
    def update
        @order.update(order_params)
        redirect_to orders_path
    end
	def edit
        
    end
    def destroy
        @order.destroy
		redirect_to orders_path
    end
	def purchase_order
        @get_order_by_owner = Order.all
		@stores = Store.all
	end
	private 
	def order_params
		params.require(:order).permit(:user_id ,:product_id ,:quantity ,:price )
	end
    def set_order
        @order = Order.find(params[:id])
	end
end
