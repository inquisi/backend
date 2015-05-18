json.first_name 	student.first_name
json.last_name 		student.last_name
json.email 			student.email
json.id 			student.id

if session.present?

#Do nothing, just return students

end
if course.present?

#Do nothing, just return students

end
if !(session.present? || course.present?)
	json.courses student.courses do |course|
		#if course belongs to instructor
		if @user.courses.include? (course)
			#add to array of courses
			json.name	course.name
			json.id 	course.id
		end
	end
end