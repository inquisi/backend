class Session < ActiveRecord::Base
	include Activatable
	
	belongs_to 	:course
	has_many 	:questions

	#Unsure If works?
	has_many 	:answers, 		:through => :questions
	
	#this would make it so that a session doesn't have a reduced roster
	#has_many 	:students, 		:through => :courses
	
	#This would make it based on responses -> so not accurate until question answered
	#Is there a better way, maybe thru sockets?
	#aLSO dO WE NEED FORIEGN KEY?
	# has_many 	:students, 		:through => :mc_responses, 	foreign_key: :user_id
	# has_many 	:students, 		:through => :sa_responses, 	foreign_key: :user_id
	# has_many 	:students, 		:through => :num_responses, foreign_key: :user_id
	# has_many 	:students, 		:through => :la_responses, 	foreign_key: :user_id

	validates 	:name, :date, 	presence: true
	validates 	:course_id, 	presence: true


	def active
		return read_attribute('active') || questions.where(active: true).any?
	end
end
