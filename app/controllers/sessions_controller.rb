class SessionsController < ApplicationController
	def create
    @session = Session.new(session_params)
    
    if @session.save
      render 'layouts/success'
    else
      @message = "Failed Create"
      render 'layouts/failure'
    end
  end

  def show
    @session = Course.find_by_course(params[:course_id])
    if(@session.present? )
      render 'session/show'
    else
      @message = "No Courses"
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
