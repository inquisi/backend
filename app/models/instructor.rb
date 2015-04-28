class Instructor < User
	has_and_belongs_to_many :courses, foreign_key: :user_id
	belongs_to 	:organization
end