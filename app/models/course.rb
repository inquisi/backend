class Course < ActiveRecord::Base

  #The instructor of the course
  belongs_to :user
  #Sessions of the course
  has_many :sessions
  #The students of the course
  has_and_belongs_to_many :courses

  validates :name, :time, presence: true
  validates :user_id, presence: true
 	
end
