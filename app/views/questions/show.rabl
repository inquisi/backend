object @question
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	course_data = { 
		name: @question.name,
		time: @question.type
		
	}
	attribute question: question_data 
end

