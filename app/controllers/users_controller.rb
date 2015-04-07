class UsersController < ApplicationController
  def signup
    @user = User.new(user_params)
    if @user.save
      # Does session even work for APIs?
      # If a user signs up properly, they should essentially log in
      # Send them a response as if they just logged in
      render 'users/token'
    else
      render json: {errors: @user.errors}
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if(@user.present? and @user.authenticate(params[:password]))
      render 'users/token'
    else
      render json: {errors: {message: "Email or password incorrect"}}
    end
  end

  # How would logout work with angular/token auth?
  # def logout
  #
  # end

private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
