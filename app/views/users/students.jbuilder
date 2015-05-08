json.array! @students do |student|
	json.partial! 'users/student', student: student, user: @user
end