class QuestionsSocketController < WebsocketRails::BaseController
	def activate
		@user = Instructor.find_by_token(message[:token])
		if @user.nil?
			trigger_failure({message: "Invalid instructor token"})
			return
		end

		@question = @user.questions.find_by_id(message[:question_id])
		if @question.nil?
			trigger_failure({message: "Question not found"})
			return
		end

		connection_store[:session_id] = @question.session.id
		@question.update(active: true)
		WebsocketRails[:"session_#{@question.session.id}".to_sym].trigger(:question_activate, @question)
		trigger_success
	end

	def deactivate
		@user = Instructor.find_by_token(message[:token])
		if @user.nil?
			trigger_failure({message: "Invalid instructor token"})
			return
		end

		@question = @user.questions.find_by_id(message[:question_id])
		if @question.nil?
			trigger_failure({message: "Question not found"})
			return
		end

		@question.update(active: false)
	end

	def session_end
		# only if instructor has left a session
		session = Session.find_by_id(connection_store[:session_id])
		if session.present?
			session.questions.update_all(active: false)
			WebsocketRails[:"session_#{connection_store[:session_id]}".to_sym].trigger(:session_end, nil)
			trigger_success
		end
	end
end