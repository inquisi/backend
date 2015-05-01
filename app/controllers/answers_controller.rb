class AnswersController < ApplicationController

	def create

		if ("MC" == Question.find_by_id(params[:question_id]))
		    @answer = McAnswer.new(name: params[:name], correct: params[:correct], order: params[:order], question_id: params[:question_id])
			if @answer.save
				render 'answers/create'
			else
				@message = "Failed to create a mc_answer"
				render nothing: true, layout: 'failure'
			end

	    elsif ("SA" == Question.find_by_id(params[:question_id]))
	    	@answer = SaAnswer.new(name: params[:name], question_id: params[:question_id])

			if @answer.save
				render 'answers/create'
			else
				@message = "Failed to create a sa_answer"
				render nothing: true, layout: 'failure'
			end

	    elsif ("NUM" == Question.find_by_id(params[:question_id]))
	    	@answer = NumAnswer.new(num: params[:num], question_id: params[:question_id])

			if @answer.save
				render 'answers/create'
			else
				@message = "Failed to create a num_answer"
				render nothing: true, layout: 'failure'
			end

	    elsif ("LA" == Question.find_by_id(params[:question_id]))
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end

	end

  	def show

	    if ("MC" == Question.find_by_id(params[:question_id]))
		    @user = User.find_by_token(params[:token])
		    @course = @user.courses.find(params[:course_id])
		    @session = @course.sessions.find(params[:session_id])
		    @question = @session.questions.find(params[:question_id])
		    @mc_answer = @question.mc_answers.find(params[:id])

		    if(@question.present? )
		      render 'answers/show'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end
	    elsif ("SA" == Question.find_by_id(params[:question_id]))
	    	@user = User.find_by_token(params[:token])
		    @course = @user.courses.find(params[:course_id])
		    @session = @course.sessions.find(params[:session_id])
		    @question = @session.questions.find(params[:question_id])
		    @sa_answer = @question.sa_answers.find(params[:id])

		    if(@sa_answer.present? )
		      render 'answers/show'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("NUM" == Question.find_by_id(params[:question_id]))
	    	@user = User.find_by_token(params[:token])
		    @course = @user.courses.find(params[:course_id])
		    @session = @course.sessions.find(params[:session_id])
		    @question = @session.questions.find(params[:question_id])
		    @num_answer = @question.num_answers.find(params[:id])

		    if(@num_answer.present? )
		      render 'answers/show'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("LA" == Question.find_by_id(params[:question_id]))
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end
	    
  	end

  	#show all
  	def index
  		
  		if ("MC" == Question.find_by_id(params[:question_id]))
		    @user = User.find_by_token(params[:token])
		    @course = @user.courses.find(params[:course_id])
		    @session = @course.sessions.find(params[:session_id])
		    @question = @session.questions.find(params[:question_id])
		    @mc_answers = @question.mc_answers

		    if(@mc_answers.present? )
		      render 'answers/index'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
	    	end

	    elsif ("SA" == Question.find_by_id(params[:question_id]))
	    	@user = User.find_by_token(params[:token])
		    @course = @user.courses.find(params[:course_id])
		    @session = @course.sessions.find(params[:session_id])
		    @question = @session.questions.find(params[:question_id])
		    @sa_answers = @question.sa_answers

		    if(@sa_answers.present? )
		      render 'answers/index'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("NUM" == Question.find_by_id(params[:question_id]))
	    	@user = User.find_by_token(params[:token])
		    @course = @user.courses.find(params[:course_id])
		    @session = @course.sessions.find(params[:session_id])
		    @question = @session.questions.find(params[:question_id])
		    @num_answers = @question.num_answers

		    if(@num_answers.present? )
		      render 'answers/index'
		    else
		      @message = "No Courses"
		      render nothing: true, layout: 'failure'
		    end

	    elsif ("LA" == Question.find_by_id(params[:question_id]))
	    	#do nothing

	    else 
	    	#do nothing
	    	#error?
	    end

  	end

end

    