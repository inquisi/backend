class LaResponse < ActiveRecord::Base
	belongs_to 		:La
	belongs_to 		:user

	validates	:name,				presence: true
	validates 	:question_id, 		presence: true
	validates	:user_id, 			presence: true
end
