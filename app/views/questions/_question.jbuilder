json.name 		question.name
json.category 	question.category
json.answers do
	json.array! question.answers do |answer|
		json.partial! 'mc_answers/mc_answer', mc_answer: answer
	end 
end