class Student < User
	#Courses that a student belong to
	has_and_belongs_to_many :courses, foreign_key: :user_id

	#For relationships 

	has_many :sessions, :through => :courses
	has_many :questions, :through => :sessions
	#Not sure if works
	has_many :answers, :through => :questions

#Have many responses
	has_many 				:mc_responses
	has_many 				:sa_responses
	has_many 				:num_responses
	has_many 				:la_responses
end