class NotEnrolledException < StandardError
	def initialize(msg = "Student not enrolled in the correct course")
		super(msg)
	end
end