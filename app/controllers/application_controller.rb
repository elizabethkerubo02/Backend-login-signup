class ApplicationController < ActionController::Base
    include ActionController::Cookies
    
    def current_user
        @current_user ||= Profile.find_by(id: session[:user_id])
    end

end