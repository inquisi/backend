class SaAnswer < ActiveRecord::Base
	belongs_to 	:question
	has_many	:sa_responses

	
	validates 	:name,			presence: true
	validates 	:question_id, 	presence: true
end
