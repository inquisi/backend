class SaAnswer < ActiveRecord::Base
	belongs_to 	:Question, class_name: "Sa"
	has_many	:responses, class_name: "SaResponse"

	validates 	:name,			presence: true
	validates 	:question_id, 	presence: true
end
