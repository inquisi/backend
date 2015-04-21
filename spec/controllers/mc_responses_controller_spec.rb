require 'rails_helper'

RSpec.describe McResponsesController, type: :controller do
	describe "create" do
	   	it "should take user_id & mc_answer_id and create response record" do
	   		# attributes_for returns a hash of values as they're defined in factories.rb
	   		expect {
	   			post :create , attributes_for(:mc_response)
	   		}.to change(McResponse, :count).by(1)
	    end
 	end
end
