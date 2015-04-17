class Question < ActiveRecord::Base
	belongs_to :session
	validates :name, :type, presence: true
	validates :session_id, presence: true
end
