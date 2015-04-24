json.array! @num_answers do |num_answer|
	json.partial! 'num_answers/num_answer', num_answer: num_answer
end