class SessionsController < ApplicationController
  
	def create
    @session = Session.new(name: params[:name], date: params[:date], course_id: params[:course_id])
    
    if @session.save
      render 'sessions/create'
    else
      @message = "Failed to create a session"
      render nothing: true, layout: 'failure'
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
      render nothing: true, layout: 'failure'
      # render 'layouts/failure'
    end

  end

  def index
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @sessions = @course.sessions

    render 'sessions/index'
  end

end