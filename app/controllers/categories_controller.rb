class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :destroy,:edit,:update]
	before_action :admin_only  ,:only => [:show,:index, :destroy,:edit,:update ] 


	def new 
		@category = Category.new    
	end
	def create 
		@category = Category.new(category_params)
		if @category.save 
           redirect_to categories_path
		end
	end
	def index 
		@categories = Category.all
	end 
	def show 
		@products = Category.find(params[:id]).products
	end
    def update
        @category.update(category_params)
        redirect_to categories_path
    end
	def edit
        
    end
    def destroy
        @category.destroy
		redirect_to categories_path
    end
	private 
	def category_params
		params.require(:category).permit(:name)
	end
    def set_category
        @category = Category.find(params[:id])
	end
end
