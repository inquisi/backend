json.token			user.token	
json.created_at 	response.created_at.to_s

if params[:mc_answer_id].present?
	json.answer_id 		response.mc_answer_id 
	
end

if question.category == "SA"	
	json.answer_id 		response.sa_answer_id 
	json.name 			response.name
	json.correct		response.correct
	
end

if question.category == "NUM"
	json.answer_id 		response.num_answer_id 
	json.num			response.num
	json.correct		response.correct

end

if question.category == "LA"
	json.question_id 	response.question_id
	json.name 			response.name
	
end