json.user_id		user.id	
json.created_at 	response.created_at.to_s
json.question_id	question.id

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
	json.name 			response.name
	
else
	json.error			"FAILED SOMEHOW"
end