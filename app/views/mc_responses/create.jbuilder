json.mc_response do
	json.partial! 'mc_responses/mc_response', mc_response: @mc_response, user: @user
end