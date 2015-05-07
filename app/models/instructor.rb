class Instructor < User
	has_and_belongs_to_many :courses, foreign_key: :user_id
	belongs_to 	:organization

	has_many 	:sessions, 		:through => :courses
	has_many 	:questions, 	:through => :sessions
	#Not sure if works-> many Answer types?
	has_many 	:answers, 		:through => :questions
end