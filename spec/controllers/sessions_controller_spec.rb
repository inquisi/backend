require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
	describe "create" do
	    it "should take a name, date and a  course_id and create a session record" do
	      # attributes_for returns a hash of values as they're defined in factories.rb
	      expect {
	        post :create , attributes_for(:session)
	      }.to change(Session, :count).by(1)
	    end
  	end
end
