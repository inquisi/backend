require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	
	describe "create" do

	    it "should take a name, category and a  session_id and create a question record" do
			# attributes_for returns a hash of values as they're defined in factories.rb
			create :instructor_with_courses_with_sessions
			session = Session.first

			expect {
			post :create , attributes_for(:mc).merge!({session_id: session.id})
			}.to change(Question, :count).by(1)
		end

	    it "should make a mc Question record" do
	      expect {
	        post :create , attributes_for(:mc)
	      }.to change(Question, :count).by(1)
	    end

	    it "should make a sa Question record" do
	      expect {
	        post :create , attributes_for(:sa)
	      }.to change(Question, :count).by(1)
	    end

	    it "should make a num Question record" do
	      expect {
	        post :create , attributes_for(:num)
	      }.to change(Question, :count).by(1)
	    end

	    it "should make a la Question record" do
	      expect {
	        post :create , attributes_for(:la)
	      }.to change(Question, :count).by(1)

	    end

  	end

end
