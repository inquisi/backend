class McAnswer < ActiveRecord::Base
	belongs_to 	:question
	has_many	:mc_responses

	
	validates 	:name, :correct, :order, 	presence: true
	validates 	:question_id, 				presence: true
end
