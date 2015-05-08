json.first_name 	student.first_name
json.last_name 		student.last_name

json.courses student.courses do |course|
	#if course belongs to instructor
	if @user.courses.include? (course)
		#add to array of courses
		json.name	course.name
		json.id 	course.id
	end
end