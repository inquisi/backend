class QuestionsController < ApplicationController
  def create
    @question = Question.new(question_params)

    if @question.save
      render 'questions/create'
    else
      @message = "Failed to create a question"
      render 'layouts/failure'
    end
  end
  #show one
  def show
    
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @question = @session.find(params[:id])

    if(@question.present? )
      render 'questions/show'
    else
      @message = "No Courses"
      render 'layouts/failure'
    end
  end
  #show all
  def index

    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @questions = @session.questions

    if(@questions.present? )
      render 'questions/index'
    else
      @message = "No Courses"
      render 'layouts/failure'
    end
  end

  private
  # Strong parameters
  # Filter out unwanted parameters so we can use mass assignment
  def question_params
    params.permit(:name, :category, :session_id)
  end
end