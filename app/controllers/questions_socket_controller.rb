class QuestionsSocketController < WebsocketRails::BaseController
	# Data passed from the client is available as `message`
	# `message` is similar to `params`

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

	def deactivate_all
		session = Session.find(connection_store[:session_id])
		if session.present?
			session.questions.update_all(active: false)
		end
	end
end