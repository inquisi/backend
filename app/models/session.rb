class Session < ActiveRecord::Base
	belongs_to 	:course
	has_many 	:questions

	# validates	:active, 		presence: true
	validates 	:name, :date, 	presence: true
	validates 	:course_id, 	presence: true
end
