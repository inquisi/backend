class NUM < Question
	has_many :answers, class_name: "NumAnswer", foreign_key: :question_id
end