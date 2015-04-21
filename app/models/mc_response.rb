class McResponse < ActiveRecord::Base
	belongs_to 		:mc_answer
	belongs_to 		:user
	validates 	:answer_id, 		presence: true
	validates	:user_id, 			presence: true
end
