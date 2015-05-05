json.name 				course.name
json.instructor			course.instructor.name
json.start 				course.start
json.finish 			course.finish
json.id					course.id
if @user.role == "Instructor"
	json.enrollment_token 	course.enrollment_token
end