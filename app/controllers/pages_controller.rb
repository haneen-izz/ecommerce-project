class PagesController < ApplicationController
  before_action :category ,only: [:guest,:highest_price,:lowest_price,:show,:search]
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

  # def product 
  # end

  def highest_price
      @products = Product.order(price: :desc)
      render :guest
  end

  def lowest_price
     @products = Product.order(price: :asc)
     render :guest
  end

  def show
    @products = Category.find(params[:id]).products
    render :guest
  end
  def search 
       @products = Product.where('name LIKE ?','%' + params[:name] + '%')
       render :guest
  end 

  private
  def category
    @categories = Category.all
  end
end
