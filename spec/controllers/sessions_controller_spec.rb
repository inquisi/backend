require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	describe "create" do

	    it "should make a session record" do
	      
	      expect {
	        post :create , attributes_for(:session)
	      }.to change(Session, :count).by(1)
	    end

  	end

end
