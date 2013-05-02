class StoreController < ApplicationController
  
  def index
    @products = Product.all
   


def search
   @products = Product.search(params[:search])
   p '+++++++++++++++++++++++products++++++++++++++++++++'
end


end
 end