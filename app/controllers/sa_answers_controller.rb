class SaAnswersController < ApplicationController
	def create
		@sa_answer = SaAnswer.new(name: params[:name], question_id: params[:question_id])

		if @sa_answer.save
			render 'sa_answers/create'
		else
			@message = "Failed to create a sa_answer"
			render 'layouts/failure'
		end

	end
  def show
    
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @question = @session.questions.find(params[:question_id])
    @sa_answer = @question.sa_answers.find(params[:id])

    if(@sa_answer.present? )
      render 'sa_answers/show'
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
    @question = @session.questions.find(params[:question_id])
    @sa_answers = @question.sa_answers

    if(@sa_answers.present? )
      render 'sa_answers/index'
    else
      @message = "No Courses"
      render 'layouts/failure'
    end
  end
end
