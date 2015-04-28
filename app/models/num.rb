class NUM < Question
	has_many :num_answers, foreign_key: :question_id
end