json.la_response do
	json.partial! 'la_responses/la_response', la_response: @la_response, user: @user
end