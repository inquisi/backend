class McAnswersController < ApplicationController
	# def create
	# 	@mc_answer = Mc_answer.new(mc_answer_params)

	# 	if @mc_answer.save
	# 		render 'mc_answers/create'
	# 	else
	# 		@message = "MC Answer creatation failed"
	# 		render 'layouts/failure'
	# 	end

	# end
    #show one
	# def show
	#   	@mc_answer = Question.find_by_session(params[:question_id])
	#   	#Find stuff HEre
	#   	#@course = @user.courses.find(params[:id])
	#   	if(@mc_answer.present? )
	#   		render 'mc_answers/show'
	#   	else
	#   		@message = "No Questions"
	#   		render 'layouts/failure'
	#   	end
	# end
	# #show all
	# def index
	#   	@mc_answer = Question.find_by_session(params[:question_id])
	#   	if(@mc_answer.present? )
	#   		render 'mc_answers/index'
	#   	else
	#   		@message = "No Question"
	#   		render 'layouts/failure'
	#   	end
	# end

	private
	# Strong parameters
	# Filter out unwanted parameters so we can use mass assignment
	def mc_answer_params
	  	params.permit(:name, :correct, :order, :question_id)
	end
end
