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
	    @product = Product.all
		file = params[:file]

	    return redirect_to products_path ,notice: "only csv file can be imported" unless params[:file].content_type=="text/csv"
		file = File.open(file)
		csv = CSV.parse(file, headers: true )
		csv.each do |row|
			unless row['ID'] == nil
			    prod = Product.find_by(id: row['ID'])
			    product_hash = {}
				product_hash[:id] = row['ID']
				product_hash[:name] = row['Name']
				product_hash[:description] = row['Description']
				product_hash[:price] = row['Price']
				product_hash[:production_date] = row['Production Date']
				product_hash[:expiration_date] = row['Expiration Date']
				product_hash[:price] = row['Price']
		        product_hash[:stock_quantity] = row['Stock Quantity']
				product_hash[:store_id] = row['Store Id']
				product_hash[:url] = row['Url']
			if prod.present?
			     prod.update(product_hash)
			else 
				Product.create!(product_hash)
			end
		 end
	  end
      redirect_to products_path
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