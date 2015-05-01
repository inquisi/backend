json.question_id 		question.id

if question.category == "MC"
	json.name	 mc_answer.name
	json.correct mc_answer.correct
	json.order	 mc_answer.order
end

if question.category == "SA"
	json.name	 sa_answer.name
end

if question.category == "NUM"
	json.num	 num_answer.num

end

if question.category == "LA"
	
end