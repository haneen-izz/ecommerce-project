class ProductsController < ApplicationController
	require 'csv'
    before_action :set_product, only: [:show, :destroy,:edit,:update , :edit_owner_product]
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
		user_role
	end
	def index 
		@products = Product.all
		paginate(5)
	end 
	def show 
	end
    def update
        @product.update(product_params)
		user_role
    end
	def edit
        
    end
    def destroy
		@product.destroy
		user_role
    end


	
    # owner product
    def owner_product 
		@products = Product.where(user_id: current_user.id)
		@user_id = current_user.id
	end 

	def new_owner_product 
		@products = Product.new    
	end
 
	def edit_owner_product  
	end
	def import
		# @product = Product.all
		file = params[:file]
		file_path = File.join(Rails.root, "tmp", file.original_filename)
		File.open(file_path, "wb") do |f|
		  f.write(file.read)
		end
		ImportCsvJob.perform_later( file_path)
	end

	private 
	def product_params
		params.require(:product).permit(:name, :description,:price ,:production_date ,:expiration_date,:stock_quantity,:store_id,:user_id ,:image)
	end
    def set_product
        @product = Product.find(params[:id])
	end
    def user_role
		case current_user.role
		when "admin"
			 redirect_to products_path 
		else
			redirect_to owner_product_path	
	    end
	end

	def all_stores
		@stores= Store.all
    end
end