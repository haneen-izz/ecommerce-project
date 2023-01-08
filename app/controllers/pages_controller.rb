class PagesController < ApplicationController
  before_action :category 
  before_action :store 
  before_action :product , only:[:index ,:guest]

  #######################################################################
  # Guest page that contains the products 
  def guest
  end

  def admin_home
  end
  def owner_home
  end

  
  def index
  end

  def highest_price
      @products = Product.order(price: :desc)
      paginate(5)
      render :guest

  end

  def lowest_price
     @products = Product.order(price: :asc)
     paginate(5)
     render :guest

  end
  def product_by_store
      @products = Store.find(params[:id]).products
      paginate(5)
      render :guest
 end

  def product_by_category
      @products = Category.find(params[:id]).products
      paginate(5)
      render :guest
  end

  #######################################################################
  # This method search for a particular product when user enter a product name even he entered only first two chars it will return the similar products with first chars
  def search 
       @products = Product.where('name LIKE ?','%' + params[:name] + '%')
       paginate(5)
       render :guest
  end 

  private
  def category
      @categories = Category.all
  end
  def store
     @stores = Store.all
  end
  def product
     @products = Product.all
     paginate(5)
  end
end