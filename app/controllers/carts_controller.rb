class CartsController < ApplicationController
	before_action :set_cart, only: [:update, :destroy]
	before_action :cart_session_timeout, only: [:index]
    
	#######################################################################
   def new
    @cart = Cart.new
   end

    def create 
		# puts "***************************",params[:cart][:product_id]
	   @cart =  Cart.find_by(product_id: params[:cart][:product_id])
		if @cart
			@cart.update(quantity:@cart.quantity + params[:cart][:quantity].to_i  )
			@cart.save
		else
			@cart = Cart.new(cart_params)
			@cart.save
		end
			
		
	end

	def index
		@cart_products = Cart.all
		@total = 0
		@multiply = 0
	end

	def cart_session_timeout
		@carts = Cart.all
		@carts.each do |cart|
        if cart.updated_at <=  Time.now  - 24.hours
		   Cart.find_by(params[id: cart.id]).destroy
		end
	  end
	end

	def update
		p '<======================params', cart_params, '================================>'
		@cart_product.update(cart_update_params)	
	end

	def destroy
		@cart_product.destroy
		redirect_to carts_path
	end
	#######################################################################
    #After the user presses checkout button all his products that he choosed will be stored in the order table
	def checkout
       if session[:user_id]
		  Cart.all.each do |cart|
		   if session[:old_rand_cart] == cart.guest_id ||session[:old_rand_cart] == cart.guest_id
			 Order.new(user_id: session[:user_id] ,price: cart.price , product_id: cart.product_id ,quantity: cart.quantity , product_name: cart.product_name).save
			 cart.destroy
		  end
	  end
          
	  else
		  redirect_to new_user_session_path
	  end

   	end
    
    private 
	def cart_params
		params.require(:cart).permit(:quantity,:product_id , :price , :guest_id ,:product_name ,:modify_date )
	end
	
	def cart_update_params
		params.require(:cart).permit(:quantity)
	end
	def order_params
	    params.require(:order).permit(:user_id ,:product_id ,:quantity ,:price ,:product_name )
	end

	def set_cart
        @cart_product = Cart.find(params[:id])
	end

end
