class Question < ActiveRecord::Base
	belongs_to 	:session
	has_many	:mc_answers
	validates 	:name, :category, presence: true
	validates 	:session_id, presence: true
end
