class LA < Question
	has_many :responses, class_name: "LaResponse", foreign_key: :question_id
end