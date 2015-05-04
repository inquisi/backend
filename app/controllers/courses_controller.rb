class CoursesController < ApplicationController

  def create

    @user = User.find_by_token(params[:token])
    @course = Course.new(name: params[:name], start: params[:start], finish: params[:finish])

    if @course.save
      @user.courses << @course
      render 'courses/create'
    else
      @message = "The course was not created"
      render nothing: true, layout: 'failure'
    end

  end

  def show
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:id])
    if(@course.present?)
      render 'courses/show'
    else
      @message = "No courses for user"
      render nothing: true, layout: 'failure'
    end
    
  end

#NEEDS TESTS
  def update
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:id])
    @course.assign_attributes(params.permit(:name, :start, :finsih, :user_id))

    if @question.save
      render 'courses/show'
    else
      @message = "Failed to save a course"
      render nothing: true, layout: 'failure'
    end
  end
  
#NEEDS TESTS
  def delete
    if Instructor.find_by_token(params[:token]).courses.find(params[:id]).delete
      @message = "Course deleted"
      render nothing: true, layout: 'application'
    else
      @message = "Error deleting course"
      render nothing: true, layout: 'failure'
    end
  end

  def index
    @user = User.find_by_token(params[:token])
    @courses = @user.courses
    render 'courses/index'
  end

end