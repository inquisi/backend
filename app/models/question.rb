class Question < ActiveRecord::Base
	self.inheritance_column = 'category'

	belongs_to 	:session


	#Validates
	validates 	:name,			 presence: true
	validates 	:session_id, 	 presence: true
	validates 	:category, inclusion: { in: ['MC', 'SA', 'LA', 'NUM'], message: "is required."}
end
