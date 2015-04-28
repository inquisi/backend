class LA < Question
	has_many :la_responses, foreign_key: :question_id
end