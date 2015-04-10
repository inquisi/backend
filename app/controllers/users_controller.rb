class UsersController < ApplicationController
  def signup
    @user = User.new(user_params)
    #Change role to boolean

    if(params[:role] == "instructor")
      @user.student = false
      @user.instructor = true
    elsif (params[:role] == "student")
      @user.student = true
      @user.instructor = false
    else
      #Error Case
      @user.student = nil
      @user.instructor = nil
    end

    if @user.save
      # Does session even work for APIs?
      # If a user signs up properly, they should essentially log in
      # Send them a response as if they just logged in
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
      @pmessage = "Email or password is incorrect"
      render 'layouts/failure'
    end

  end

 #Logout handled on front end

  private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
