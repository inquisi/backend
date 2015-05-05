class Course < ActiveRecord::Base
	#Sessions of the course
	has_many :sessions
	#The students of the course
	has_and_belongs_to_many :students, association_foreign_key: :user_id, distinct: true
	has_and_belongs_to_many :instructors, association_foreign_key: :user_id

	validates :name, :start, :finish, presence: true

	before_save :generate_enrollment_token

	def instructor
		instructors.first
	end

	def instructor=(instructor)
		instructors = [instructor]
	end

private
	def generate_enrollment_token
		self.enrollment_token = rand(100000..1000000)
	end

end