class MC < Question
	has_many :mc_answers , foreign_key: :question_id
end