class UsersController < ApplicationController
  def signup
    @user = User.new(user_params)

    if @user.save
      render 'users/token'
    else
      @message = @user.errors.full_messages[0]
      render 'layouts/failure'
    end
  end
 
  def login
    @user = User.find_by_email(params[:email])
    if(@user.present? and @user.authenticate(params[:password]))
      render 'users/token'
    else
      @message = "Email or password is incorrect"
      render 'layouts/failure'
    end

  end

  def show
    @user = User.find_by_token(params[:token])
    if(@user.present? )
      render 'users/show'
    else
      @message = "Invalid User"
      render 'layouts/failure'
    end
  end

  private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end
end