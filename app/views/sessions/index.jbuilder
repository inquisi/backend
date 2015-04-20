json.array! @sessions do |session|
	json.partial! 'sessions/session', session: session
end