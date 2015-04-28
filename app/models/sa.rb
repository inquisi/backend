class SA < Question
	has_many :sa_answers, foreign_key: :question_id
end