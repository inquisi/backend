json.sa_response do
	json.partial! 'responses/response', response: @response, user: @user, question: @question
end
