class ResponsesController < ApplicationController

	def create 

		# @question = Question.find_by_id(params[:question_id])
		
		if (params[:mc_answer_id].present?)
			@user = User.find_by_token(params[:token])
			@response = McResponse.new(user_id: @user.id, mc_answer_id: params[:mc_answer_id])
			
			if 	@response.save
				render 'responses/create'
			else
				@message = "Failed to create a mc_response"
				render nothing: true, layout: 'failure'
			end

	    elsif (params[:sa_answer_id].present?)

	    	#Get Info
	    	@user = User.find_by_id(params[:user_id])
	    	@response = SaResponse.new(user_id: params[:user_id], sa_answer_id: params[:sa_answer_id], name: params[:name], correct: false)
			
			
			#Check correctness
			answer = SaAnswer.find_by_id(params[:sa_answer_id])
			n = answer.name


			#BECAUSE STRINGS => LETS CONDITION INPUT
			store = answer.name
			input = params[:name]
			
			#NIL checks becuase if input bad, downcase fails
			if store != nil
				store.downcase.capitalize
			end
			if input != nil
				input.downcase.capitalize
			end
###### IF NOT CONDITIONING STRINGS  #########
			# if n == params[:name]
			# 	@response.correct = true
			# end
##############################################

			if store == input
				@response.correct = true
			end
	
			#Save It / Error Message
			if 	@response.save
				render 'responses/create'
			else
				@message = "Failed to create a sa_response"
				render nothing: true, layout: 'failure'
			end

	    elsif (params[:num_answer_id].present?)

	    	#Get Info
	    	@user = User.find_by_id(params[:user_id])
	    	@response = NumResponse.new(user_id: params[:user_id], num_answer_id: params[:num_answer_id], num: params[:num], correct: false)
			

			#Check correctness
			answer = NumAnswer.find_by_id(params[:num_answer_id])
			number = answer.num
			if number == params[:num]
				@response.correct = true
			end

			#Save It / Error Message
			if 	@response.save
				render 'responses/create'
			else
				@message = "Failed to create a num_response"
				render nothing: true, layout: 'failure'
			end	

	    elsif (params[:question_id].present?)
	    	@user = User.find_by_id(params[:user_id])
		    @response = LaResponse.new(user_id: params[:user_id], question_id: params[:question_id], name: params[:name])
			
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

	    if (params[:mc_answer_id].present?)
		   	@user 		 = 	User.find_by_token(params[:token])
		   	# @response = @user.mc_responses.find_by_id(params[:id])
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

	    elsif (params[:sa_answer_id].present?)
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

	    elsif (params[:num_answer_id].present?)
			 
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

	    elsif (params[:question_id].present?)
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
  		
  		if (params[:mc_answer_id].present?)
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

	    elsif (params[:sa_answer_id].present?)
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

	    elsif (params[:num_answer_id].present?)
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
	    	
	    elsif (params[:question_id].present?)
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

  	def update
  		
	    if (params[:mc_answer_id].present?)
		   	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer 	 =	@question.answers.find(params[:mc_answer_id])
	    	@response 	 = 	@answer.responses.find(params[:id])

			@response.assign_attributes(params.permit(:name, :correct, :mc_answer_id, :order))
		    if @response.save
		      render 'responses/show'
		    else
		      @message = "Failed to update a response"
		      render nothing: true, layout: 'failure'
		    end

	    elsif (params[:sa_answer_id].present?)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer   	 = 	@question.answers.find(params[:sa_answer_id])
	    	@response 	 =	@answer.responses.find(params[:id])
	    	
			@response.assign_attributes(params.permit(:name, :correct, :sa_answer_id))
		    if @response.save
		      render 'responses/show'
		    else
		      @message = "Failed to update a response"
		      render nothing: true, layout: 'failure'
		    end

	    elsif (params[:num_answer_id].present?)
			 
			@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer  	 = 	@question.answers.find(params[:num_answer_id])
	    	@response 	 =	@answer.responses.find(params[:id])
	    	
			@response.assign_attributes(params.permit(:num, :correct, :num_answer_id))
		    if @response.save
		      render 'responses/show'
		    else
		      @message = "Failed to update a response"
		      render nothing: true, layout: 'failure'
		    end  	

	    elsif (params[:question_id].present?)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@response 	 =	@question.responses.find(params[:id])
	    	
			@response.assign_attributes(params.permit(:name, :question_id))
		    if @response.save
		      render 'responses/show'
		    else
		      @message = "Failed to update a response"
		      render nothing: true, layout: 'failure'
		    end
		  	
	    else 
	    	@message = "ERROR END OF CONTROLLER"
		  	render nothing: true, layout: 'failure'
	    end
	    


  	end





  	def delete
  		
	    if (params[:mc_answer_id].present?)
		   	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer 	 =	@question.answers.find(params[:mc_answer_id])
	    	@response 	 = 	@answer.responses.find(params[:id])
			if(@response.delete )
		  	  @message = "response deleted"
		      render nothing: true, layout: 'application'
		    else
		      @message = "Error deleting response"
		      render nothing: true, layout: 'failure'
		    end

	    elsif (params[:sa_answer_id].present?)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer   	 = 	@question.answers.find(params[:sa_answer_id])
	    	@response 	 =	@answer.responses.find(params[:id])
	    	
			if(@response.delete )
		  	  @message = "response deleted"
		      render nothing: true, layout: 'application'
		    else
		      @message = "Error deleting response"
		      render nothing: true, layout: 'failure'
		    end

	    elsif (params[:num_answer_id].present?)
			 
			@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer  	 = 	@question.answers.find(params[:num_answer_id])
	    	@response 	 =	@answer.responses.find(params[:id])
	    	
			if(@response.delete )
		  	  @message = "response deleted"
		      render nothing: true, layout: 'application'
		    else
		      @message = "Error deleting response"
		      render nothing: true, layout: 'failure'
		    end  	

	    elsif (params[:question_id].present?)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@response 	 =	@question.responses.find(params[:id])
	    	
			if(@response.delete )
		  	  @message = "response deleted"
		      render nothing: true, layout: 'application'
		    else
		      @message = "Error deleting response"
		      render nothing: true, layout: 'failure'
		    end
		  	
	    else 
	    	@message = "ERROR END OF CONTROLLER"
		  	render nothing: true, layout: 'failure'
	    end


 	end

 	def deleteAll

	    if (params[:mc_answer_id].present?)
		   	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer 	 =	@question.answers.find(params[:mc_answer_id])
	    	@responses 	 = 	@answer.responses

			#Iterate thru answers?
			@responses.each do |response|
				if response.delete
					@message = "responses deleted"
					render nothing: true, layout: 'application'
				else
					@message = "Error deleting responses"
					render nothing: true, layout: 'failure'
				end

			end	

	    elsif (params[:sa_answer_id].present?)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer   	 = 	@question.answers.find(params[:sa_answer_id])
	    	@responses 	 = 	@answer.responses

			#Iterate thru answers?
			@responses.each do |response|
				if response.delete
					@message = "responses deleted"
					render nothing: true, layout: 'application'
				else
					@message = "Error deleting responses"
					render nothing: true, layout: 'failure'
				end

			end	

	    elsif (params[:num_answer_id].present?)
			 
			@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@answer  	 = 	@question.answers.find(params[:num_answer_id])
	    	@responses 	 = 	@answer.responses

			#Iterate thru answers?
			@responses.each do |response|
				if response.delete
					@message = "responses deleted"
					render nothing: true, layout: 'application'
				else
					@message = "Error deleting responses"
					render nothing: true, layout: 'failure'
				end

			end	 	

	    elsif (params[:question_id].present?)
	    	@user 		 = 	User.find_by_token(params[:token])
	   		@course 	 = 	@user.courses.find(params[:course_id])
	    	@session 	 = 	@course.sessions.find(params[:session_id])
	    	@question 	 = 	@session.questions.find(params[:question_id])
	    	@responses 	 = 	@question.responses

			#Iterate thru answers?
			@responses.each do |response|
				if response.delete
					@message = "responses deleted"
					render nothing: true, layout: 'application'
				else
					@message = "Error deleting responses"
					render nothing: true, layout: 'failure'
				end

			end	
		  	
	    else 
	    	@message = "ERROR END OF CONTROLLER"
		  	render nothing: true, layout: 'failure'
	    end

	end
	
end