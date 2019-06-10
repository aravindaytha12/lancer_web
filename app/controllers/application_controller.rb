class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :get_category_list

	def get_category_list
		@categories = Category.all
	end
end
