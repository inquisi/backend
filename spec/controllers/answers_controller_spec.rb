require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

	describe "create" do

		it "should make a MC ANSWER record" do
	      	student = create :instructor_with_mcA
	      	course = student.courses.first
	    	session = course.sessions.first
	    	question = session.questions.first
			expect {
	     	   post :create , attributes_for(:mcA, question_id: question.id)
	      	}.to change(McAnswer, :count).by(1)
	    end

	    it "should make a SA ANSWER record" do
	    	student = create :instructor_with_saA
	      	course = student.courses.first
	    	session = course.sessions.first
	    	question = session.questions.first
	      	expect {
	     	   post :create , attributes_for(:saA, question_id: question.id)
	      	}.to change(SaAnswer, :count).by(1)
	    end

	    it "should make a NUM ANSWER record" do
	    	student = create :instructor_with_numA
	      	course = student.courses.first
	    	session = course.sessions.first
	    	question = session.questions.first
	      	expect {
	     	   post :create , attributes_for(:numA, question_id: question.id)
	      	}.to change(NumAnswer, :count).by(1)
	    end

	    it "should make a LA ANSWER record" do
	      	#Do Nothing
	      	#matt rules the world 
	    end

 	end

end
