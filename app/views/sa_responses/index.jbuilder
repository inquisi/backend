json.array! @mc_responses do |mc_response|
	json.partial! 'mc_responses/mc_response', mc_response: mc_response, user: @user
end