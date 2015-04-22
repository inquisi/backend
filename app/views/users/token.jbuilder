json.user do
	json.token @user.token
	json.partial! 'users/user', user: @user
end