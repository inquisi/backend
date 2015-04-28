class NumAnswersController < ApplicationController
	def create
		@num_answer = NumAnswer.new(num: params[:num], question_id: params[:question_id])

		if @num_answer.save
			render 'num_answers/create'
		else
			@message = "Failed to create a num_answer"
			render nothing: true, layout: 'failure'
		end

	end
  def show
    
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @question = @session.questions.find(params[:question_id])
    @num_answer = @question.num_answers.find(params[:id])

    if(@num_answer.present? )
      render 'num_answers/show'
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
    @question = @session.questions.find(params[:question_id])
    @num_answers = @question.num_answers

    if(@num_answers.present? )
      render 'num_answers/index'
    else
      @message = "No Courses"
      render nothing: true, layout: 'failure'
    end
  end
end
