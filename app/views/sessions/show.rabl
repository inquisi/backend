object @session
node (:status) { "success" }
node (:message) { "" }
node (:data) do 
	session_data = { 
		name: @session.name,
		time: @session.date
		
	}
	attribute session: session_data 
end

