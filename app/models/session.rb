class Session < ActiveRecord::Base
	belongs_to :course
	validates :name, :date, presence: true
	validates :course_id, presence: true
end
