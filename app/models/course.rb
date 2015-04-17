class Course < ActiveRecord::Base

	#The instructor of the course
	belongs_to :user
	#Sessions of the course
	has_many :sessions
	#The students of the course
  	has_and_belongs_to_many :users

  	validates :name, :start, :finish, presence: true
  	validates :user_id, presence: true
 	
	before_save :generate_token

 	def generate_token
    	self.token = SecureRandom.uuid
    end
    
  	private
  	# Make the 'token' setter private
 	# So that it can't be set directly
 	# It should be set with 'generate_token'
 	def token=(t)
 	   write_attribute(:token, t)
	end
end
