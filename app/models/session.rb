class Session < ActiveRecord::Base
	include Activatable

	after_initialize :set_allow_anonymous_default
	before_save :generate_session_token_if_allow_anonymous_enabled
	
	belongs_to 	:course
	has_many 	:questions
	has_many 	:answers, 		:through => :questions

	validates 	:name, :date, 	presence: true
	validates 	:course_id, 	presence: true


	def active
		return read_attribute('active') || questions.where(active: true).any?
	end

	def set_allow_anonymous_default
		write_attribute('allow_anonymous', false) if read_attribute('allow_anonymous').blank?	
	end

	def generate_session_token_if_allow_anonymous_enabled
		if(self.allow_anonymous_changed? && self.allow_anonymous_was == false && self.allow_anonymous == true)
			token = SecureRandom.hex(3)
			while(Session.find_by_token(token) != nil)
				token = SecureRandom.hex(3)
			end

			self.token = token
		end
	end
end
