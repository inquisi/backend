class SessionsSocketController < WebsocketRails::BaseController
	def student_join
		WebsocketRails[message[:channel_name]].trigger("student.join_session".to_sym, message[:user])
		connection_store[:user] = message[:user]
		connection_store[:session_channel] = message[:channel_name]
	end	

	def student_leave
		if(connection_store[:user].present?)
			WebsocketRails[connection_store[:session_channel]].trigger("student.leave_session".to_sym, connection_store[:user])
		end
	end
end