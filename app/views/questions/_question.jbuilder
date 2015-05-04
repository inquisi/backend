json.id 		question.id
json.name 		question.name
json.category 	question.category
json.order 		question.order
json.active		question.active
json.answers do
	json.array! question.answers do |answer|
		json.partial! 'answers/answer', answer: answer, question: question
	end 
end
