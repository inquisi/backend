class QuestionsController < ApplicationController
	def create
    	@question = Question.new(question_params)
    	
   	    if @question.save
            render 'layouts/success'
        else
      		@message = "Failed Create"
     		render 'layouts/failure'
    	end
 	end




private
    # Strong parameters
    # Filter out unwanted parameters so we can use mass assignment
    def question_params
   		params.permit(:name, :category, :session_id)
  	end


end
