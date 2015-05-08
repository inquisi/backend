require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	describe "create" do

	    it "should make a session record" do
        instructor = create(:instructor_with_courses)
	      
	      expect {
	        post :create , attributes_for(:session, token: instructor.token, course_id: instructor.courses.first.id)
	      }.to change(Session, :count).by(1)
	    end

  	end

end
