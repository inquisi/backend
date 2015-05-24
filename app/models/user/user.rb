class User < ActiveRecord::Base
	self.inheritance_column = 'role'

	POSSIBLE_ROLES = ['Student', 'Instructor', 'AnonymousStudent']
	
	validates 	:role, inclusion: { in: POSSIBLE_ROLES, message: "is required."}

	before_validation 	:transform_role
	before_save 		:generate_token

	def generate_token
		self.token = SecureRandom.uuid
	end

	def transform_role
		if(self.role)
			POSSIBLE_ROLES.each do |role|
				if(role.casecmp(self.role) == 0)
					self.role = role
				end
			end
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
