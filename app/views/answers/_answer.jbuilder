json.question_id 		question.id

if question.category == "MC"
	json.name	 answer.name
	json.correct answer.correct
	json.order	 answer.order
end

if question.category == "SA"
	json.name	 answer.name
end

if question.category == "NUM"
	json.num	 answer.num

end

if question.category == "LA"
	
end