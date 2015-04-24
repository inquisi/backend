class NumAnswer < ActiveRecord::Base
	belongs_to 	:question
	has_many	:num_responses

	
	validates 	:num,			presence: true
	validates 	:question_id, 	presence: true
end
