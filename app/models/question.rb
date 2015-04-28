class Question < ActiveRecord::Base
	belongs_to 	:session
	self.inheritance_column = 'category' #currently category
	
	#Validates
	validates 	:name,			 presence: true
	validates 	:session_id, 	 presence: true

	validates 	:category, inclusion: { in: ['MC', 'SA', 'LA', 'NUM'], message: "is required."}
end

