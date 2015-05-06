class UsersController < ApplicationController

  def signup

    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], role: params[:role])
    if @user.save
      render 'users/token'
    else
      @message = @user.errors.full_messages[0]
      render nothing: true, layout: 'failure'
    end
  end
 
  def login

    @user = User.find_by_email(params[:email])
    if(@user.present? and @user.authenticate(params[:password]))
      render 'users/token'
    else
      @message = "Email or password is incorrect"
      render nothing: true, layout: 'failure'
    end

  end

  def show

    @user = User.find_by_token(params[:token])
    if(@user.present? )
      render 'users/show'
    else
      @message = "Invalid User"
      render nothing: true, layout: 'failure'
    end

  end

  def update

    @user = User.find_by_token(params[:token])
    #Check for switching email to already assigned email? -> potential problem
    @user.assign_attributes(params.permit(:first_name, :last_name, :email, :trial))

    if @user.save
      render 'users/show'
    else
      @message = "Failed to update a user"
      render nothing: true, layout: 'failure'
    end

  end
  
end