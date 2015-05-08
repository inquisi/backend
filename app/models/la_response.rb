class LaResponse < ActiveRecord::Base
	belongs_to 		:Question, class_name: "La"
	belongs_to 		:user,		class_name: "Student", foreign_key: :user_id

	validates	:name,				presence: true
	validates 	:question_id, 		presence: true
	validates	:user_id, 			presence: true
end
