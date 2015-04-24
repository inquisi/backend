class SaResponse < ActiveRecord::Base
	belongs_to 		:sa_answer
	belongs_to 		:user

	validates	:name,				presence: true
	validates 	:sa_answer_id, 		presence: true
	validates	:user_id, 			presence: true
end
