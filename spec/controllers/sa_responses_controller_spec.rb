require 'rails_helper'

RSpec.xdescribe SaResponsesController, type: :controller do
	describe "create" do
	    it "should take a name, user_id and a sa_answer_id and create an response record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:sa_response)
	      	}.to change(SaResponse, :count).by(1)
	    end
 	end
end
