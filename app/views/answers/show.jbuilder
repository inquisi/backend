json.answer do
	json.partial! 'answers/answer', answer: @answer, question: @question
end