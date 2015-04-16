class CoursesController < ApplicationController
  def create
    @course = Course.new(course_params)

    if @course.save
      render 'layouts/success'
    else
      @message = "Failed Create"
      render 'layouts/failure'
    end
  end

  def show
    @course = Course.find_by_user(params[:email])
    if(@course.present? )
      render 'course/show'
    else
      @message = "No Courses"
      render 'layouts/failure'
    end
  end
private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def course_params
    params.permit(:name, :time, :user_id)
  end
	
end
