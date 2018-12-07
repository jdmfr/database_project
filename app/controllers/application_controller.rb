class ApplicationController < ActionController::Base
	helper_method :star_text
	helper_method :current
	helper_method :is_admin
	helper_method :is_belonger
	protected

	def star_text
		return @favorite_exists ? "Unstar" : "Star" 
	end


	def is_admin 
		current_user.id==1? true : false 
	end
	
	def is_belonger( owner )
		current_user.id==owner ? true: false
	end


	protected

	def current
		@current||= User.find(current_user.id )
		unless @current_user
			redirect_to login_url , alert: "please log in"
		end
		@current
	end

	
	def star_text
		return @favorite_exists? "Unstar" : "Star" 
	end
end
