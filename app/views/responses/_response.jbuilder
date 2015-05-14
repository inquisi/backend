json.token			user.token	
json.created_at 	response.created_at.to_s

if question.category == "MC"	
	json.answer_id 		response.mc_answer_id 
	
elsif question.category == "SA"	
	json.answer_id 		response.sa_answer_id 
	json.name 			response.name
	json.correct		response.correct
	
elsif question.category == "NUM"
	json.answer_id 		response.num_answer_id 
	json.num			response.num
	json.correct		response.correct

elsif question.category == "LA"
	json.question_id 	response.question_id
	json.name 			response.name
	
else
	json.error			"FAILED SOMEHOW"
end