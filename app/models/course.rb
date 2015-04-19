class Course < ActiveRecord::Base
	#Sessions of the course
	has_many :sessions
	#The students of the course
	has_and_belongs_to_many :students, association_foreign_key: :user_id
	has_and_belongs_to_many :instructors, association_foreign_key: :user_id

	validates :name, :start, :finish, presence: true
	# validates :instructors, length: { minimum: 1, message: "must have at least one instructor." }

	# Behind the scenes course has a many to many relationship with instructor
	# Right now we want to hide that and/or provide a convenience method to add
	# 	just one instructor rather than an array of instructors 
	# before_create :add_instructor

	def instructor
		instructors.first
	end

	def instructor=(instructor)
		instructors = [instructor]
	end

# private
# 	# Allows passing an :instructor to Course.create
# 	# rather than :instructors => [Instructor]
# 	def add_instructor
# 		instructors = [instructor]
# 	end
end