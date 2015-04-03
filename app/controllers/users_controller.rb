class UsersController < ApplicationController
  def login

  end

  def logout

  end

  def signup
    user = User.create(user_params)
    session['current_user'] = user
    render json: user
  end

private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
