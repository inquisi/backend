json.token			user.token	

if question.category == "MC"
	json.created_at 	mc_response.created_at.to_s
end

if question.category == "SA"	
	json.name 			sa_response.name
	json.created_at 	sa_response.created_at.to_s
end

if question.category == "NUM"
	json.num			num_response.num
	json.created_at 	num_response.created_at.to_s

end

if question.category == "LA"
	json.name 			la_response.name
	json.created_at 	la_response.created_at.to_s
end