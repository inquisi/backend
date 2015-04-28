require 'rails_helper'

RSpec.describe LaResponsesController, type: :controller do
	describe "create" do
	    it "should take a name, user_id and a question_id and create an response record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:la_response)
	      	}.to change(LaResponse, :count).by(1)
	    end
 	end
end