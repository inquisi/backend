object @user
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	attribute user: { token: @user.token }
end