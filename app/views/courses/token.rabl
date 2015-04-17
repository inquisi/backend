object @course
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	attribute course: { token: @course.token }
end