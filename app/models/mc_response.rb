class McResponse < ActiveRecord::Base
	belongs_to 		:answer, class_name: "McAnswer"
	belongs_to 		:student

	validates 	:mc_answer_id, 		presence: true
	validates	:user_id, 			presence: true
end
