class LA < Question
	has_many :responses, class_name: "LaResponse", foreign_key: :question_id

	# return the created response
	def respond(student_id, question_id)
		student = Student.find(student_id)
		question = questions.find(question_id)

		if(!session.course.students.include?(student))
			raise NotEnrolledException, "Student with id #{student.id} cannot respond to question with id #{question.id} because they are not enrolled in that question's course"
		end

		old_student_responses = question.responses.where(user_id: student_id)
		if(old_student_responses.any?)
			old_student_responses.destroy_all
		end

		return question.responses.create!(user_id: student_id)
	end
end