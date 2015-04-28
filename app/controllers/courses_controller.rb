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

  def index
    @user = User.find_by_token(params[:token])
    @courses = @user.courses
    render 'courses/index'
  end
end