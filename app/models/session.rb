class Session < ActiveRecord::Base
	belongs_to 	:course
	has_many 	:questions

	validates 	:active, inclusion: { in: [true, false] }
	validates 	:name, :date, 	presence: true
	validates 	:course_id, 	presence: true
end
