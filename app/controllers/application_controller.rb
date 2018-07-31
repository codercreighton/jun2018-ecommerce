class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  before_action :categories, :brands

# created data for our categories dropdown
  def categories
  	@categories = Category.order(:name)
  end	

# creates data for our brands dropdown
  def brands
  	@brands = Product.pluck(:brand).sort.uniq
  end	
end
