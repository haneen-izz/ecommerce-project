class ProductCategoriesController < ApplicationController
	before_action :admin_only  ,:only => [:show,:index, :destroy,:edit,:update] 
    before_action :set_product_category, only: [:show, :destroy,:edit,:update]
    before_action :all_product_category, only: [:edit,:new]

    
   def new 
	   @product_category = ProductCategory.new      
   end

   def index 
       @product_category =  ProductCategory.all   
   end
    
   def create 
       @product_category = ProductCategory.new(product_category_params)
	   @product_category.save 
       redirect_to product_categories_path
   end

   def show 
   end

   def update
       @product_category.update(product_category_params)
       redirect_to product_categories_path
   end

   def edit
        
   end

       def destroy
           @product_category.destroy
           redirect_to product_categories_path
       end
    private 
	  def product_category_params
		  params.require(:product_category).permit(:category_id, :product_id)
    end
    def set_product_category
           @product_category = ProductCategory.find(params[:id])
	end
    def all_product_category
         @products = Product.all
         @categories = Category.all
    end
end