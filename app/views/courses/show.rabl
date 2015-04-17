object @course
node (:status) { "success" }
node (:message) { "" }
node (:data) do
	course_data = {}
	if(@course.present?)
		course_data[:name] = @course.name
		course_data[:start] = @course.start
		course_data[:finish] = @course.finish
	end

	if(@courses.present?)
		course_data = []
		@courses.each do |course|
			course_hash = {}
			course_hash[:name] = @course.name
			course_hash[:start] = @course.start
			course_hash[:finish] = @course.finish
			
			course_data.push course_hash
		end
	end 
	
	attribute course: course_data 
end

