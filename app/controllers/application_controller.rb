class ApplicationController < ActionController::Base
  protect_from_forgery

  # Pick a unique cookie name to distinguish our session data from others'
#  session :session_key => '_simple_blog'
  #session :disabled => true
  
  private #------------
	
	def authorize_access
	  if !session[:user_id]
	    flash[:notice] = "Please log in."
	    redirect_to(:controller => 'staff', :action => 'login')
	    return false
	  end	
	end


end
