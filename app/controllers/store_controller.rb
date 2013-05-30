class StoreController < ApplicationController
  require "rubygems"
  require "twitter"
  
  def index
    @products = Product.all
 


def search
   @products = Product.search(params[:search])
   p '+++++++++++++++++++++++products++++++++++++++++++++'
end
end

def category
  p params[:category]
  @product=Product.find_by_category(params[:category])
  render(:template => "products/search_results")
  p 11111111111111111111111111111111
  p @product
  p 1111111111111111111111111111111
  end
 

 end