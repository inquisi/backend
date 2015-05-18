class McAnswer < ActiveRecord::Base
	belongs_to 	:question, class_name: "MC"

	has_many	:responses, class_name: "McResponse"

	validates 	:name, :order,			 	presence: true
	validates 	:correct, 					inclusion: { in: [true, false] }
	validates 	:question_id, 				presence: true
end
