class NumResponsesController < ApplicationController
	def create
		@num_response = NumResponse.new(user_id: params[:user_id], num_answer_id: params[:num_answer_id], num: params[:num])
		@user = User.find_by_id(params[:user_id])
		if 	@num_response.save
			render 'num_responses/create'
		else
			@message = "Failed to create a num_response"
			render nothing: true, layout: 'failure'
		end

	end
 	#    #show one
	def show
	  	@user 		 = 	User.find_by_token(params[:token])
   		@course 	 = 	@user.courses.find(params[:course_id])
    	@session 	 = 	@course.sessions.find(params[:session_id])
    	@question 	 = 	@session.questions.find(params[:question_id])
    	@num_answer  = 	@question.num_answers.find(params[:num_answer_id])
    	@num_response =	@num_answer.num_responses.find(params[:id])
    	
		if(@num_response.present? )
	  		render 'num_responses/show'
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
    	@num_answer   	= @question.num_answers.find(params[:num_answer_id])
    	@num_responses 	= @num_answer.num_responses

	  	if(@num_responses.present? )
	  		render 'num_responses/index'
	  	else
	  		@message = "No Responses"
	  		render nothing: true, layout: 'failure'
	  	end
	end
end
