class NumAnswer < ActiveRecord::Base
	belongs_to 		:Question, class_name: "Num"
	has_many	:responses, class_name: "NumResponse"

	validates 	:num,			presence: true
	validates 	:question_id, 	presence: true
end
