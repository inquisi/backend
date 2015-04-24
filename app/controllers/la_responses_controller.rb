class LaResponsesController < ApplicationController
	def create
		@la_response = LaResponse.new(user_id: params[:user_id], question_id: params[:question_id], name: params[:name])
		@user = User.find_by_id(params[:user_id])
		if 	@la_response.save
			render 'la_responses/create'
		else
			@message = "Failed to create a la_response"
			render 'layouts/failure'
		end

	end
 	#    #show one
	def show
	  	@user 		 = 	User.find_by_token(params[:token])
   		@course 	 = 	@user.courses.find(params[:course_id])
    	@session 	 = 	@course.sessions.find(params[:session_id])
    	@question 	 = 	@session.questions.find(params[:question_id])
    	@la_response =	@question.la_responses.find(params[:id])
    	
		if(@la_response.present? )
	  		render 'la_responses/show'
	  	else
	  		@message = "No Response"
	  		render 'layouts/failure'
	  	end
	end
	#show all
	def index
	  	@user 			= User.find_by_token(params[:token])
   		@course 		= @user.courses.find(params[:course_id])
    	@session 	 	= @course.sessions.find(params[:session_id])
    	@question 		= @session.questions.find(params[:question_id])
    	@la_responses 	= @question.la_responses

	  	if(@la_responses.present? )
	  		render 'la_responses/index'
	  	else
	  		@message = "No Responses"
	  		render 'layouts/failure'
	  	end
	end
end
