require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do
	describe "create" do
		it "should mc response record" do
			student = create :student_with_mcR
	    	course = student.courses.first
	    	session = course.sessions.first
	    	question = session.questions.first
	    	answer = question.answers.first
	      	expect {
	   			post :create , attributes_for(:mcR, token: student.token, mc_answer_id: answer.id, question_id: question.id)
	   		}.to change(McResponse, :count).by(1)
	    end

	    it "should sa response record" do
	    	student = create :student_with_saR
	    	course = student.courses.first
	    	session = course.sessions.first
	    	question = session.questions.first
	    	answer = question.answers.first
	      	expect {
	     	   post :create , attributes_for(:saR, token: student.token, sa_answer_id: answer.id, question_id: question.id)
	      	}.to change(SaResponse, :count).by(1)
	    end
	    
	    it "should num response record" do
	    	student = create :student_with_numR
	    	course = student.courses.first
	    	session = course.sessions.first
	    	question = session.questions.first
	    	answer = question.answers.first
	      	expect {
	     	   post :create , attributes_for(:numR, token: student.token, num_answer_id: answer.id, question_id: question.id)
	      	}.to change(NumResponse, :count).by(1)
	    end
	    
	    it "should la response record" do
	    	student = create :student_with_laR
	    	course = student.courses.first
	    	session = course.sessions.first
	    	question = session.questions.first
	      	expect {
	     	   post :create , attributes_for(:laR, token: student.token, question_id: question.id)
	      	}.to change(LaResponse, :count).by(1)
	    end

 	end

end
