json.sa_response do
	json.partial! 'sa_responses/sa_response', sa_response: @sa_response, user: @user
end