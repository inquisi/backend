class McAnswer < ActiveRecord::Base
	belongs_to 	:question
	has_many	:mc_responses

	validates 	:name, :order,			 	presence: true
	validates 	:correct, inclusion: { in: [true, false] }
	validates 	:question_id, 				presence: true
end
