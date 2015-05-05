class Question < ActiveRecord::Base
	include Activatable

	self.inheritance_column = 'category'

	belongs_to 	:session
	
	validates 	:name,			 presence: true
	validates 	:session_id, 	 presence: true
	validates 	:category, inclusion: { in: ['MC', 'SA', 'LA', 'NUM'], message: "is required."}
end