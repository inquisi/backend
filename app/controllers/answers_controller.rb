class AnswersController < ApplicationController

	def create

		@question = Question.find_by_id(params[:question_id])
		if ("MC" == @question.category)
		    @answer = McAnswer.new(name: params[:name], correct: params[:correct], order: params[:order], question_id: params[:question_id])
			if @answer.save
				render 'answers/create'
			else
				@message = "Failed to create a mc_answer"
				render nothing: true, layout: 'failure'
			end

	    elsif ("SA" == @question.category)
	    	@answer = SaAnswer.new(name: params[:name], question_id: params[:question_id])

			if @answer.save
				render 'answers/create'
			else
				@message = "Failed to create a sa_answer"
				render nothing: true, layout: 'failure'
			end

	    elsif ("NUM" == @question.category)
	    	@answer = NumAnswer.new(num: params[:num], question_id: params[:question_id])

			if @answer.save
				render 'answers/create'
			else
				@message = "Failed to create a num_answer"
				render nothing: true, layout: 'failure'
			end

	    elsif ("LA" == @question.category)
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end

	end

  	def show

  		@question = Question.find_by_id(params[:question_id])
	    if ("MC" == @question.category)
		    @user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])

		    if(@answer.present? )
		      render 'answers/show'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("SA" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])

		    if(@answer.present? )
		      render 'answers/show'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("NUM" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])

		    if(@answer.present? )
		      render 'answers/show'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("LA" == @question.category)
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end
	    
  	end

  	#show all
  	def index
  		
  		@question = Question.find_by_id(params[:question_id])
  		if ("MC" == @question.category)
		    @user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answers = @question.answers

		    if(@answers.present? )
		      render 'answers/index'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
	    	end

	    elsif ("SA" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answers = @question.answers

		    if(@answers.present? )
		      render 'answers/index'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("NUM" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answers = @question.answers

		    if(@answers.present? )
		      render 'answers/index'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("LA" == @question.category)
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end

  	end

  	#Update
  	def update

    	@question = Question.find_by_id(params[:question_id])
  		if ("MC" == @question.category)
		    @user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])

		    @answer.assign_attributes(params.permit(:name, :correct, :question_id, :order))
		    if @answer.save
		      render 'answers/show'
		    else
		      @message = "Failed to update a answer"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("SA" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])

		    @answer.assign_attributes(params.permit(:name, :question_id))
		    if @answer.save
		      render 'answers/show'
		    else
		      @message = "Failed to update a answer"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("NUM" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])

		    @answer.assign_attributes(params.permit(:num, :question_id))
		    if @answer.save
		      render 'answers/show'
		    else
		      @message = "Failed to update a answer"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("LA" == @question.category)
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end

	end

	    #DELETE
  	def delete

    	@question = Question.find_by_id(params[:question_id])
    	
  		if ("MC" == @question.category)
		    @user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])
			
			if @answer.delete
			    @message = "Answer deleted"
			    render nothing: true, layout: 'application'
			else
			    @message = "Error deleting question"
			    render nothing: true, layout: 'failure'
			end
		    
		    

	    elsif ("SA" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])
		    if @answer.delete
			    @message = "Answer deleted"
			    render nothing: true, layout: 'application'
			else
			    @message = "Error deleting question"
			    render nothing: true, layout: 'failure'
			end
		    

	    elsif ("NUM" == @question.category)
	    	@user = User.find_by_token(params[:token])
		    @question = @user.questions.find(params[:question_id])
		    @answer = @question.answers.find(params[:id])
		    if @answer.delete
			    @message = "Answer deleted"
			    render nothing: true, layout: 'application'
			else
			    @message = "Error deleting question"
			    render nothing: true, layout: 'failure'
			end
		    

	    elsif ("LA" == @question.category)
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end
  	end

end

    