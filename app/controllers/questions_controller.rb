class QuestionsController < ApplicationController
  def create
    @question = MC.new(name: params[:name], session_id: params[:session_id])

    if @question.save
      render 'questions/create'
    else
      @message = "Failed to create a question"
      render nothing: true, layout: 'failure'
    end
  end
  #show one
  def show
    
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @question = @session.questions.find(params[:id])

    if(@question.present? )
      render 'questions/show'
    else
      @message = "No Courses"
      render nothing: true, layout: 'failure'
    end
  end
  #show all
  def index
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @questions = @session.questions

    render 'questions/index'
  end
end