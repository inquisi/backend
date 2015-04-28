class QuestionsController < ApplicationController
  skip_before_filter :authenticate_and_set_user, except: [:show, :index]

  def create
    @question = MC.new(name: params[:name], session_id: params[:session_id], order: params[:order])

    if @question.save
      render 'questions/create'
    else
      @message = "Failed to create a question"
      render nothing: true, layout: 'failure'
    end
  end
  #show one
  def show
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
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @questions = @session.questions

    render 'questions/index'
  end
end