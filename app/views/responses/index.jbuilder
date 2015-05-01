json.array! @responses do |response|
	json.partial! 'responses/response', response: response, user: @user, question: @question
end