class QuestionsController < ApplicationController
  
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


  def update
    @user = User.find_by_token(params[:token])
    @question = @user.questions.find(params[:id])
    @question.assign_attributes(params.permit(:name, :cateogry, :session_id, :order))

    if @question.save
      render 'questions/show'
    else
      @message = "Failed to save a question"
      render nothing: true, layout: 'failure'
    end
  end

  def delete
    if Instructor.find_by_token(params[:token]).questions.find(params[:id]).delete
      @message = "Question deleted"
      render nothing: true, layout: 'application'
    else
      @message = "Error deleting question"
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