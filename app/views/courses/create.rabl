object @course
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	attribute course: { name: @course.name, start: @course.start, finish: @course.finish  }
end