json.array! @students do |student|
	if @session
		json.partial! 'users/students', student: student, user: @user, session: @session
	else
		json.partial! 'users/students', student: student, user: @user
	end
end