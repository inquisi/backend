class LaResponse < ActiveRecord::Base
	belongs_to 		:Question, class_name: "La"
	#belongs_to 		:La
	#belongs_to 		:user
	belongs_to 		:user,		class_name: "Student"

	validates	:name,				presence: true
	validates 	:question_id, 		presence: true
	validates	:user_id, 			presence: true
end
