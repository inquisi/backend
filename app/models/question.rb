class Question < ActiveRecord::Base
	belongs_to 	:session
	#has_many Questions (various types)
	has_many	:mc_answers
	#has_many ...
	#has_many ...
	

	#Validates
	validates 	:name, :category, presence: true
	validates 	:session_id, presence: true
end
