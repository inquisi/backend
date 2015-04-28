json.array! @num_responses do |num_response|
	json.partial! 'num_responses/num_response', num_response: num_response, user: @user
end