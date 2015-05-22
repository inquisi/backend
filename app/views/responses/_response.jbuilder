json.user_id		response.user_id	
json.created_at 	response.created_at.to_s
json.question_id	response.answer.question_id

if response.class.name == "McResponse"	
	json.answer_id 		response.mc_answer_id 
	
elsif response.class.name == "SaResponse"	
	json.answer_id 		response.sa_answer_id 
	json.name 			response.name
	json.correct		response.correct
	
elsif response.class.name == "NumResponse"
	json.answer_id 		response.num_answer_id 
	json.num			response.num
	json.correct		response.correct

elsif response.class.name == "LaResponse"
	json.name 			response.name
end