class Question < ActiveRecord::Base
	belongs_to :session
	validates :name, :category, presence: true
	validates :session_id, presence: true
end
