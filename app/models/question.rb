class Question < ActiveRecord::Base
	belongs_to 	:session
	#has_many Questions (various types)
	has_many	:mc_answers
	has_many	:sa_answers
	has_many	:num_answers
	#LA don't have a answer
	has_many	:la_responses
	

	#Validates
	validates 	:name, :category, presence: true
	validates 	:session_id, presence: true
end
