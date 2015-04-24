json.array! @sa_answers do |sa_answer|
	json.partial! 'sa_answers/sa_answer', sa_answer: sa_answer
end