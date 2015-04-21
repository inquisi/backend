class McResponsesController < ApplicationController
	def create
		@mc_response = McResponse.new(mc_response_params)

		if @mc_response.save
			render 'mc_responses/create'
		else
			@message = "MC response creatation failed"
			render 'layouts/failure'
		end

	end
 	#    #show one
	# def show
	#   	@mc_response = Question.find_by_session(params[:answer_id])
	#   	#Find stuff HEre
	#   	#@course = @user.courses.find(params[:id])
	#   	if(@mc_response.present? )
	#   		render 'mc_responses/show'
	#   	else
	#   		@message = "No Questions"
	#   		render 'layouts/failure'
	#   	end
	# end
	# #show all
	# def index
	#   	@mc_response = Question.find_by_session(params[:answer_id])
	#   	if(@mc_response.present? )
	#   		render 'mc_responses/index'
	#   	else
	#   		@message = "No Question"
	#   		render 'layouts/failure'
	#   	end
	# end

	private
	# Strong parameters
	# Filter out unwanted parameters so we can use mass assignment
	def mc_response_params
	  	params.permit(:user_id, :question_id)
	end
end
