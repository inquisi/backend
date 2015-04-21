json.array! @mc_answers do |mc_answer|
	json.partial! 'mc_answers/mc_answer', mc_answer: mc_answer
end