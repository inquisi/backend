class ResponsesController < ApplicationController

	def create
		if ("MC" == Question.find_by_id(params[:question_id]))
		   	@response = McResponse.new(user_id: params[:user_id], mc_answer_id: params[:mc_answer_id])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'mc_responses/create'
			else
				@message = "Failed to create a mc_response"
				render nothing: true, layout: 'failure'
			end

	    elsif ("SA" == Question.find_by_id(params[:question_id]))
	    	@response = SaResponse.new(user_id: params[:user_id], sa_answer_id: params[:sa_answer_id], name: params[:name])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'sa_responses/create'
			else
				@message = "Failed to create a sa_response"
				render nothing: true, layout: 'failure'
			end

	    elsif ("NUM" == Question.find_by_id(params[:question_id]))
	    	@response = NumResponse.new(user_id: params[:user_id], num_answer_id: params[:num_answer_id], num: params[:num])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'num_responses/create'
			else
				@message = "Failed to create a num_response"
				render nothing: true, layout: 'failure'
			end	

	    elsif ("LA" == Question.find_by_id(params[:question_id]))
		    @response = LaResponse.new(user_id: params[:user_id], question_id: params[:question_id], name: params[:name])
			@user = User.find_by_id(params[:user_id])
			if 	@response.save
				render 'la_responses/create'
			else
				@message = "Failed to create a la_response"
				render nothing: true, layout: 'failure'
			end

	    else 
	    	#do nothing
	    	#error?
	    end
		

	end

  	def show
	    if ("MC" == Question.find_by_id(params[:question_id]))
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
		  		render nothing: true, layout: 'failure'
		  	end

	    elsif ("SA" == Question.find_by_id(params[:question_id]))
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

	    elsif ("NUM" == Question.find_by_id(params[:question_id]))
			 
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

	    elsif ("LA" == Question.find_by_id(params[:question_id]))
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@la_response =	@question.la_responses.find(params[:id])
	    	
			if(@la_response.present? )
		  		render 'la_responses/show'
		  	else
		  		@message = "No Response"
		  		render nothing: true, layout: 'failure'
		  	end
		  	
	    else 
	    	#do nothing
	    	#error?
	    end
	    

  	end

  	#show all
  	def index
  		if ("MC" == Question.find_by_id(params[:question_id]))
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
		  		render nothing: true, layout: 'failure'
		  	end

	    elsif ("SA" == Question.find_by_id(params[:question_id]))
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

	    elsif ("NUM" == Question.find_by_id(params[:question_id]))
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
	    	
	    elsif ("LA" == Question.find_by_id(params[:question_id]))
	    	@user 			= User.find_by_token(params[:token])
	   		@course 		= @user.courses.find(params[:course_id])
	    	@session 	 	= @course.sessions.find(params[:session_id])
	    	@question 		= @session.questions.find(params[:question_id])
	    	@la_responses 	= @question.la_responses
	    	
		  	if(@la_responses.present? )
		  		render 'la_responses/index'
		  	else
		  		@message = "No Responses"
		  		render nothing: true, layout: 'failure'
		  	end

	    else 
	    	#do nothing
	    	#error?
	    end

  	end

end
	def create


	end
 	#    #show one
	def show
	  	
	end
	#show all
	def index
	  	
	end