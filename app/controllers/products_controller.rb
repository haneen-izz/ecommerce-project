class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :destroy,:edit,:update , :edit_owner_product, :update_owner_product, :destroy_owner_product]
    before_action :admin_only  ,:only => [:show,:index, :destroy,:edit,:update ] 
	before_action :all_stores

	# customer product
	def new 
		@product = Product.new    
	end
	def create 
		@product = Product.new(product_params)
		@product.user = current_user
	    @product.save 
        redirect_to products_path
	end
	def index 
		@products = Product.all
	end 
	def show 
	end
    def update
        @product.update(product_params)
        redirect_to products_path
    end
	def edit
        
    end
    def destroy
        @product.destroy
		redirect_to products_path
    end

	
    # owner product
    def owner_product 
		@products = Product.where(user_id: current_user.id)
		@user_id = current_user.id
	end 
	def new_owner_product 
		@products = Product.new    
	end
    def create_owner_product 
		
		@product = Product.new(product_params)
		@product.user = current_user
	    @product.save 
        redirect_to owner_product_path   
	end
	def edit_owner_product 
	    
	end
	def update_owner_product 
	    @product.update(product_params)
        redirect_to owner_product_path
	end
	def destroy_owner_product
        @product.destroy
		redirect_to owner_product_path
    end
	private 
	def product_params
		params.require(:product).permit(:name, :description,:price ,:production_date ,:expiration_date,:stock_quantity,:store_id,:user_id ,:image)
	end
    def set_product
        @product = Product.find(params[:id])
	end
	def all_stores
		@stores= Store.all
    end
end
