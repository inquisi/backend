class SA < Question
	has_many :answers, class_name: "SaAnswer", foreign_key: :question_id

	# return the created response
	def respond(student_id, answer_id)
		student = Student.find(student_id)
		answer = answers.find(answer_id)

		if(!session.course.students.include?(student))
			raise NotEnrolledException, "Student with id #{student.id} cannot respond to answer with id #{answer.id} because they are not enrolled in that answer's course"
		end

		old_student_responses = answer.question.responses.where(user_id: student_id)
		if(old_student_responses.any?)
			old_student_responses.destroy_all
		end

		return answer.responses.create!(user_id: student_id)
	end
	
end