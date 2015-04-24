class NumResponse < ActiveRecord::Base
	belongs_to 		:num_answer
	belongs_to 		:user

	validates	:num,				presence: true
	validates 	:num_answer_id, 	presence: true
	validates	:user_id, 			presence: true
end
