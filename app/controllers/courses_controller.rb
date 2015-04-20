class CoursesController < ApplicationController
  def create
    @course = Course.new(course_params)
    if @course.save
      render 'courses/create'
    else
      @message = "The course was not created"
      render 'layouts/failure'
    end
  end

  def show
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:id])
    if(!@course.present?)
      @status = "failure"
      @message = "No courses for user"
      render 'layouts/'
    else
      render 'courses/show'
    end
  end

  def index
    @user = User.find_by_token(params[:token])
    @courses = @user.courses
    render 'courses/index'
  end

  private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def course_params
    #id is Rails Params for choosing just one class
    params.permit(:name, :start, :finish, :user_id)
  end
  
end
