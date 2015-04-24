json.array! @sa_responses do |sa_response|
	json.partial! 'sa_responses/sa_response', sa_response: sa_response
end