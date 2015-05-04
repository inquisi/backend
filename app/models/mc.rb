class MC < Question

	has_many :answers, class_name: "McAnswer" , foreign_key: :question_id

end