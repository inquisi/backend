class McResponse < ActiveRecord::Base
	alias_attribute :answer_id, :mc_answer_id

	belongs_to 		:answer, 	class_name: "McAnswer"
	belongs_to 		:user,		class_name: "Student", foreign_key: :user_id
	
	validates 	:mc_answer_id, 		presence: true
	validates	:user_id, 			presence: true
end
