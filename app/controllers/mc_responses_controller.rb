class McResponsesController < ApplicationController
	def create
		@mc_response = McResponse.new(user_id: params[:user_id], mc_answer_id: params[:mc_answer_id])
		@user = User.find_by_id(params[:user_id])
		if 	@mc_response.save
			render 'mc_responses/create'
		else
			@message = "Failed to create a mc_response"
			render 'layouts/failure'
		end

	end
 	#    #show one
	def show
	  	@user 		 = 	User.find_by_token(params[:token])
   		@course 	 = 	@user.courses.find(params[:course_id])
    	@session 	 = 	@course.sessions.find(params[:session_id])
    	@question 	 = 	@session.questions.find(params[:question_id])
    	@mc_answer 	 =	@question.mc_answers.find(params[:mc_answer_id])
    	@mc_response = 	@mc_answer.mc_responses.find(params[:id])
    	
		if(@mc_response.present? )
	  		render 'mc_responses/show'
	  	else
	  		@message = "No Responses"
	  		render 'layouts/failure'
	  	end
	end
	#show all
	def index
	  	@user 			= User.find_by_token(params[:token])
   		@course 		= @user.courses.find(params[:course_id])
    	@session 	 	= @course.sessions.find(params[:session_id])
    	@question 		= @session.questions.find(params[:question_id])
    	@mc_answer 	 	= @question.mc_answers.find(params[:mc_answer_id])
    	@mc_responses 	= @mc_answer.mc_responses

	  	if(@mc_responses.present? )
	  		render 'mc_responses/index'
	  	else
	  		@message = "No Response"
	  		render 'layouts/failure'
	  	end
	end
end
