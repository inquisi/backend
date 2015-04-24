json.array! @la_responses do |la_response|
	json.partial! 'la_responses/la_response', la_response: la_response
end