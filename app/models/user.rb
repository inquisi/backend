class User < ActiveRecord::Base
	has_secure_password
	0
	self.inheritance_column = 'role'

	validates 	:first_name, :last_name, presence: true
	validates 	:email, uniqueness: true, email: true
	validates 	:role, inclusion: { in: ['Student', 'Instructor'], message: "is required."}

	before_validation 	:capitalize_role
	before_save 		:generate_token

	def generate_token
		self.token = SecureRandom.uuid
	end

	def capitalize_role
		if(self.role)
			self.role = self.role.capitalize
		end
	end

	def name
		"#{first_name} #{last_name}"
	end

private
	# Make the 'token' setter private
	# So that it can't be set directly
	# It should be set with 'generate_token'
	def token=(t)
		write_attribute(:token, t)
	end
end
