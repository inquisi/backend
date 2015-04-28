class CoursesController < ApplicationController
  def create
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
    @course = @user.courses.find(params[:id])
    if(@course.present?)
      render 'courses/show'
    else
      @message = "No courses for user"
      render nothing: true, layout: 'failure'
    end
  end

  def index
    @courses = @user.courses
    render 'courses/index'
  end
end