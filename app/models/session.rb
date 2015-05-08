class Session < ActiveRecord::Base
	include Activatable
	
	belongs_to 	:course
	has_many 	:questions

	#Unsure If works?
	has_many 	:answers, 		:through => :questions

	validates 	:name, :date, 	presence: true
	validates 	:course_id, 	presence: true
end
