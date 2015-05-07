class Student < User
	has_and_belongs_to_many :courses, foreign_key: :user_id
	has_many :sessions, :through => :courses
	has_many 				:mc_responses
	has_many 				:sa_responses
	has_many 				:num_responses
	has_many 				:la_responses
end