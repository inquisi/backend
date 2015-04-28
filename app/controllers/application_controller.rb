class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_filter :authenticate_and_set_user

  protected

  def authenticate_and_set_user
	@user = User.find_by_token(params[:token])
	if !@user.present?
		render 'standard_responses/unauthorized', layout: 'failure'
	end
  end
end