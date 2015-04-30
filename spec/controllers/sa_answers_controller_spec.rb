require 'rails_helper'

RSpec.xdescribe SaAnswersController, type: :controller do
	describe "create" do
	    it "should take a name and a question_id and create an answer record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:sa_answer)
	      	}.to change(SaAnswer, :count).by(1)
	    end
 	end
end
