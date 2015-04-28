class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_with_token_and_set_user(options = {})
  	before_action(options) do
  		@user = User.find_by_token(params[:token])
  		if !@user.present?
  			
  		end
  	end
  end
end
