class CoursesController < ApplicationController

#IMPLEMENT CRUD (Create, Read, Update, Delete)
# Create -> create, Read -> show, Update -> update, Delete -> delete
#Is this good


  def create
    @user = Instructor.find_by_token(params[:token])
    if !@user.present?
      @message = "Instructor authentication error"
      render nothing: true, layout: 'failure'
      return
    end

    @course = @user.courses.new(name: params[:name], start: params[:start], finish: params[:finish])
    @course.instructors << @user

    if @course.save
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

    if @course.save
      render 'courses/show'
    else
      @message = "Failed to save a course"
      render nothing: true, layout: 'failure'
    end
  end

#NEEDS TESTS
  def delete

    user = Instructor.find_by_token(params[:token])
    if user.courses.find(params[:id]).delete
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

  def enroll
    @user = User.find_by_token(params[:token])

    if(@user.role == "Instructor")
      @message = "Instructors can't enroll in courses"
      render nothing: true, layout: 'failure'
      return
    end

    enrollment_token = params[:enrollment_token]
    @course = Course.find_by_enrollment_token(enrollment_token)

    if(!@course.present?)
      @message = "Incorrect enrollment code"
      render nothing: true, layout: 'failure'
      return
    end
    
    @course.students << @user unless @course.students.include? @user

    @message = "You've been enrolled"
    render 'courses/show', layout: 'application'
  end
end