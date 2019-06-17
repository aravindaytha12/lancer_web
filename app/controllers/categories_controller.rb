class CategoriesController < ApplicationController
  def index
    categories = Category.all
    sub_categories_hash = Hash.new
    categories.each do |cat|
      sub_categories_hash["#{}"]  
    end
  end

  def services
    @category = Category.find(params[:id])
    @services = @category.services.page(params[:page]).per(6)
  end


  private
  def set_category
  	
  end
end
