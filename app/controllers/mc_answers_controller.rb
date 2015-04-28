class McAnswersController < ApplicationController
	def create
		@mc_answer = McAnswer.new(name: params[:name], correct: params[:correct], order: params[:order], question_id: params[:question_id])

		if @mc_answer.save
			render 'mc_answers/create'
		else
			@message = "Failed to create a mc_answer"
			render nothing: true, layout: 'failure'
		end

	end
  def show
    
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:session_id])
    @question = @session.questions.find(params[:question_id])
    @mc_answer = @question.mc_answers.find(params[:id])

    if(@question.present? )
      render 'mc_answers/show'
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
    @mc_answers = @question.mc_answers

    if(@mc_answers.present? )
      render 'mc_answers/index'
    else
      @message = "No Courses"
      render nothing: true, layout: 'failure'
    end
  end
end
