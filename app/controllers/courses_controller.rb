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

    if(params[:id].present?)
      @course = Course.find(params[:id])
      
      if(!@course.present?)
        @message = "No courses for user"
        render 'layouts/failure'
      else
        render 'courses/show'
      end
    else
      @courses = Course.where(user_id: @user.id)
      puts @courses[0].inspect
      render 'courses/courses'
    end
  end

private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def course_params
    #id is Rails Params for choosing just one class
    params.permit(:name, :start, :finish, :user_id)
  end
	
end
