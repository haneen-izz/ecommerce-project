class PagesController < ApplicationController
  before_action :category ,only: [:guest,:highest_price,:lowest_price,:show,:search]
  before_action :store ,only: [:guest,:highest_price,:lowest_price,:show,:search,:product_by_store]

  #######################################################################
  # Guest page that contains the products 
  def guest
    @products = Product.all
  end

  def admin_home
  end
  def owner_home
  end

  
  def index
     @products = Product.all 
  end

  def highest_price
      @products = Product.order(price: :desc)
      render :guest
  end

  def lowest_price
     @products = Product.order(price: :asc)
     render :guest
  end
  def product_by_store
      @stores = Store.find(params[:id]).products
      render :guest
 end

  def show
    @products = Category.find(params[:id]).products
    render :guest
  end

  #######################################################################
  # This method search for a particular product when user enter a product name even he entered only first two chars it will return the similar products with first chars
  def search 
       @products = Product.where('name LIKE ?','%' + params[:name] + '%')
       render :guest
  end 

  private
  def category
    @categories = Category.all
  end
  def store
    @stores = Store.all
  end
end
