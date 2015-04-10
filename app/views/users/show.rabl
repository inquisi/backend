object @user
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	if (@user.instructor == true)
 		attribute user: { 
 			first_name: @user.first_name, last_name: @user.last_name, 
			email: @user.email,
 			organization: @user.organization,
 			role: "instructor"
 		}
 	else
 		attribute user: { 
 			first_name: @user.first_name, last_name: @user.last_name, 
			email: @user.email,
 			role: "student"
 		}
 	end

end

