class Question < ActiveRecord::Base
	belongs_to 	:session
	self.inheritance_column = 'category' #currently category
	# def self.types
 	#      %w(LA MC NUM SA)
 	# end


	# #has_many Questions (various types)
	# has_many	:mc_answers
	# has_many	:sa_answers
	# has_many	:num_answers
	# #LA don't have a answer
	# has_many	:la_responses
	

	#Validates
	validates 	:name,			 presence: true
	validates 	:session_id, 	 presence: true

	validates 	:category, inclusion: { in: ['MC', 'SA', 'LA', 'NUM'], message: "is required."}
end

