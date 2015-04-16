object @course
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	course_data = { 
		name: @course.name,
		time: @course.time
		
	}
	attribute course: course_data 
end

