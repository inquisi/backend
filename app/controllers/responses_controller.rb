class ResponsesController < ApplicationController

	def create 

		@question = Question.find_by_id(params[:question_id])
		if ("MC" == @question.category)
			@response = McResponse.new(user_id: params[:user_id], mc_answer_id: params[:mc_answer_id])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'responses/create'
			else
				@message = "Failed to create a mc_response"
				render nothing: true, layout: 'failure'
			end

	    elsif ("SA" == @question.category)
	    	@response = SaResponse.new(user_id: params[:user_id], sa_answer_id: params[:sa_answer_id], name: params[:name])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'responses/create'
			else
				@message = "Failed to create a sa_response"
				render nothing: true, layout: 'failure'
			end

	    elsif ("NUM" == @question.category)
	    	@response = NumResponse.new(user_id: params[:user_id], num_answer_id: params[:num_answer_id], num: params[:num])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'responses/create'
			else
				@message = "Failed to create a num_response"
				render nothing: true, layout: 'failure'
			end	

	    elsif ("LA" == @question.category)
		    @response = LaResponse.new(user_id: params[:user_id], question_id: params[:question_id], name: params[:name])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'responses/create'
			else
				@message = "Failed to create a la_response"
				render nothing: true, layout: 'failure'
			end

	    else 
	    	@message = "ERROR END OF CONTROLLER"
		  	render nothing: true, layout: 'failure'
	    end
		

	end

  	def show

  		@question = Question.find_by_id(params[:question_id])
	    if ("MC" == @question.category)
		   	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer 	 =	@question.answers.find(params[:mc_answer_id])
	    	@response 	 = 	@answer.responses.find(params[:id])
	    	
			if(@response.present? )
		  		render 'responses/show'
		  	else
		  		@message = "No Responses"
		  		render nothing: true, layout: 'failure'
		  	end

	    elsif ("SA" == @question.category)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer   	 = 	@question.answers.find(params[:sa_answer_id])
	    	@response 	 =	@answer.responses.find(params[:id])
	    	
			if(@response.present? )
		  		render 'responses/show'
		  	else
		  		@message = "No Response"
		  		render nothing: true, layout: 'failure'
		  	end

	    elsif ("NUM" == @question.category)
			 
			@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer  	 = 	@question.answers.find(params[:num_answer_id])
	    	@response 	 =	@answer.responses.find(params[:id])
	    	
			if(@response.present? )
		  		render 'responses/show'
		  	else
		  		@message = "No Response"
		  		render nothing: true, layout: 'failure'
		  	end   	

	    elsif ("LA" == @question.category)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@response 	 =	@question.responses.find(params[:id])
	    	
			if(@response.present? )
		  		render 'responses/show'
		  	else
		  		@message = "No Response"
		  		render nothing: true, layout: 'failure'
		  	end
		  	
	    else 
	    	@message = "ERROR END OF CONTROLLER"
		  	render nothing: true, layout: 'failure'
	    end
	    

  	end

  	#show all
  	def index

  		@question = Question.find_by_id(params[:question_id])
  		if ("MC" == @question.category)
		    @user 			= User.find_by_token(params[:token])
	   		@course 		= @user.courses.find(params[:course_id])
	    	@session 	 	= @course.sessions.find(params[:session_id])
	    	@question 		= @session.questions.find(params[:question_id])
	    	@answer 	 	= @question.answers.find(params[:mc_answer_id])
	    	@responses 	  	= @answer.responses

		  	if(@responses.present? )
		  		render 'responses/index'
		  	else
		  		@message = "No Response"
		  		render nothing: true, layout: 'failure'
		  	end

	    elsif ("SA" == @question.category)
	    	@user 			= User.find_by_token(params[:token])
	   		@course 		= @user.courses.find(params[:course_id])
	    	@session 	 	= @course.sessions.find(params[:session_id])
	    	@question 		= @session.questions.find(params[:question_id])
	    	@answer   		= @question.answers.find(params[:sa_answer_id])
	    	@responses 		= @answer.responses

		  	if(@responses.present? )
		  		render 'responses/index'
		  	else
		  		@message = "No Responses"
		  		render nothing: true, layout: 'failure'
		  	end

	    elsif ("NUM" == @question.category)
	    	@user 			= User.find_by_token(params[:token])
	   		@course 		= @user.courses.find(params[:course_id])
	    	@session 	 	= @course.sessions.find(params[:session_id])
	    	@question 		= @session.questions.find(params[:question_id])
	    	@answer   		= @question.answers.find(params[:num_answer_id])
	    	@responses 		= @answer.responses

		  	if(@responses.present? )
		  		render 'responses/index'
		  	else
		  		@message = "No Responses"
		  		render nothing: true, layout: 'failure'
		  	end
	    	
	    elsif ("LA" == @question.category)
	    	@user 			= User.find_by_token(params[:token])
	   		@course 		= @user.courses.find(params[:course_id])
	    	@session 	 	= @course.sessions.find(params[:session_id])
	    	@question 		= @session.questions.find(params[:question_id])
	    	@responses 		= @question.responses
	    	
		  	if(@responses.present? )
		  		render 'responses/index'
		  	else
		  		@message = "No Responses"
		  		render nothing: true, layout: 'failure'
		  	end

	    else 
	    	@message = "ERROR END OF CONTROLLER"
		  	render nothing: true, layout: 'failure'
	    end

  	end

end