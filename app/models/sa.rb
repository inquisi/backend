class SA < Question
	has_many :answers, class_name: "SaAnswer", foreign_key: :question_id
end