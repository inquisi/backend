class Course < ActiveRecord::Base
	#Sessions of the course
	has_many :sessions
	#For Active relations
	has_many 	:questions, 	:through => :sessions
	#Unsure If works?
	has_many 	:answers, 		:through => :questions

	#The students of the course
	has_and_belongs_to_many :students, 		association_foreign_key: :user_id, 	distinct: true
	has_and_belongs_to_many :instructors, 	association_foreign_key: :user_id

	validates :name, :start, :finish, presence: true
	validates :instructors, length: { minimum: 1 }

	before_save :generate_enrollment_token



	def instructor
		instructors.first
	end

	def instructor=(instructor)
		instructors = [instructor]
	end

	def active
		sessions.where(active: true).any?
	end

private
	def generate_enrollment_token
		#Intail code
		enroll = rand(100000..1000000)
		#Continue getting new enroll token until a unique one is found
		while Course.find_by_enrollment_token(enroll).present?
			enroll = rand(100000..1000000)
		end
		#Assign it to course 
		self.enrollment_token = enroll

	end

end