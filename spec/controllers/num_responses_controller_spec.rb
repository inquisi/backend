require 'rails_helper'

RSpec.xdescribe NumResponsesController, type: :controller do
	describe "create" do
	    it "should take a num, user_id and a num_answer_id and create an response record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:num_response)
	      	}.to change(NumResponse, :count).by(1)
	    end
 	end
end
