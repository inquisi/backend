class NumResponse < ActiveRecord::Base
	belongs_to 		:answer, 	class_name: "NumAnswer"
	belongs_to 		:user,		class_name: "Student"
	
	validates	:num,				presence: true
	validates 	:num_answer_id, 	presence: true
	validates	:user_id, 			presence: true
end
