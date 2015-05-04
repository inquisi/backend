json.array! @answers do |answer|
	json.partial! 'answers/answer', answer: answer, question: @question
end