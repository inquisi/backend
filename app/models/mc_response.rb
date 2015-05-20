require 'render_anywhere'
class McResponse < ActiveRecord::Base
	include RenderAnywhere

	alias_attribute :answer_id, :mc_answer_id

	belongs_to 		:answer, 	class_name: "McAnswer", foreign_key: :mc_answer_id
	belongs_to 		:user,		class_name: "Student", foreign_key: :user_id
	
	validates 	:mc_answer_id, 		presence: true
	validates	:user_id, 			presence: true


	def as_json
		JSON.parse(render(
						'responses/_response.jbuilder', 
						locals: { 
							user: user, 
							question: answer.question, 
							response: self
						}, 
						layout: false ), 
					symbolize_names: true)
	end
end
