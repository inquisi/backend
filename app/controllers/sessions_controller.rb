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
    @course = Course.find_by_course(params[:course_id])
    @session = @course.sessions.find(params[:id])
    if(@session.present? )
      render 'sessions/show'
    else
      @message = "No Sessions"
      render 'layouts/failure'
    end
  end

  def index
    @session = Course.find_by_course(params[:course_id])
    if(@session.present? )
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
