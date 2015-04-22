class McAnswersController < ApplicationController
	def create
		@mc_answer = McAnswer.new(mc_answer_params)

		if @mc_answer.save
			render 'mc_answers/create'
		else
			@message = "Failed to create a mc_answer"
			render 'layouts/failure'
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
      render 'layouts/failure'
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
      render 'layouts/failure'
    end
  end

	private
	# Strong parameters
	# Filter out unwanted parameters so we can use mass assignment
	def mc_answer_params
	  	params.permit(:name, :correct, :order, :question_id)
	end
end
