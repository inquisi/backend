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
    # @question = Question.find_by_session(params[:session_id]) #not sure it correct
    @course = Course.find_by_course(params[:course_id])
    @session = @course.sessions.find(params[:id])
    @question = @course.sessions.questions.find(params[:id])

    if(@question.present? )
      render 'questions/show'
    else
      @message = "No Courses"
      render 'layouts/failure'
    end
  end
  #show all
  def index
    @question = Session.find_by_session(params[:session_id])
    if(@question.present? )
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