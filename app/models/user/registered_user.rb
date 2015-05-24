class RegisteredUser < User
	has_secure_password

	validates 	:first_name, :last_name, presence: true
	validates 	:email, uniqueness: true, email: true
end