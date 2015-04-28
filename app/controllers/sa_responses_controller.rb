class SaResponsesController < ApplicationController
	def create
		@sa_response = SaResponse.new(user_id: params[:user_id], sa_answer_id: params[:sa_answer_id], name: params[:name])
		@user = User.find_by_id(params[:user_id])
		if 	@sa_response.save
			render 'sa_responses/create'
		else
			@message = "Failed to create a sa_response"
			render nothing: true, layout: 'failure'
		end

	end
 	#    #show one
	def show
	  	@user 		 = 	User.find_by_token(params[:token])
   		@course 	 = 	@user.courses.find(params[:course_id])
    	@session 	 = 	@course.sessions.find(params[:session_id])
    	@question 	 = 	@session.questions.find(params[:question_id])
    	@sa_answer   = 	@question.sa_answers.find(params[:sa_answer_id])
    	@sa_response =	@sa_answer.sa_responses.find(params[:id])
    	
		if(@sa_response.present? )
	  		render 'sa_responses/show'
	  	else
	  		@message = "No Response"
	  		render nothing: true, layout: 'failure'
	  	end
	end
	#show all
	def index
	  	@user 			= User.find_by_token(params[:token])
   		@course 		= @user.courses.find(params[:course_id])
    	@session 	 	= @course.sessions.find(params[:session_id])
    	@question 		= @session.questions.find(params[:question_id])
    	@sa_answer   	= @question.sa_answers.find(params[:sa_answer_id])
    	@sa_responses 	= @sa_answer.sa_responses

	  	if(@sa_responses.present? )
	  		render 'sa_responses/index'
	  	else
	  		@message = "No Responses"
	  		render nothing: true, layout: 'failure'
	  	end
	end
end
