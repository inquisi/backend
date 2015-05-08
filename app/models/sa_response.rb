class SaResponse < ActiveRecord::Base
	belongs_to 		:answer, 	class_name: "SaAnswer"
	belongs_to 		:user,		class_name: "Student", foreign_key: :user_id

	#For checking correctness
	validates 	:correct, 			inclusion: { in: [true, false] }

	validates	:name,				presence: true
	validates 	:sa_answer_id, 		presence: true
	validates	:user_id, 			presence: true
end
