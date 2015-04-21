class SessionsController < ApplicationController
	def create
    @session = Session.new(session_params)
    
    if @session.save
      render 'sessions/create'
    else
      @message = "Failed to create a session"
      render 'layouts/failure'
    end
  end

  def show
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:id])
    if(@session.present? )
      render 'sessions/show'
    else
      @message = "No Sessions"
      render 'layouts/failure'
    end
  end

  def index
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @sessions = @user.courses.sessions

    if(@sessions.present? )
      render 'sessions/index'
    else
      @message = "No Sessions"
      render 'layouts/failure'
    end
  end

  private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def session_params
    params.permit(:name, :date, :course_id)
  end
end
