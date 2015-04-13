object @user
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	user_data = { 
		first_name: @user.first_name, last_name: @user.last_name, 
		email: @user.email,
		role: @user.role
	}
	if @user.role == "Instructor"
		user_data[:organization] = @user.organization
	end

	attribute user: user_data 
end

