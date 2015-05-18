json.array! @students do |student|
	if @session
		json.partial! 'users/students', student: student, user: @user, course: @course, session: @session
	end
	if @course
		json.partial! 'users/students', student: student, user: @user, course: @course, session: @session
	end
	if !(@session.present? || @course.present?)
		json.partial! 'users/students', student: student, user: @user, course: @course, session: @session
	end
end