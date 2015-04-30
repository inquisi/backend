require 'rails_helper'

RSpec.xdescribe NumAnswersController, type: :controller do
	describe "create" do
	    it "should take a num, and a question_id and create an answer record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:num_answer)
	      	}.to change(NumAnswer, :count).by(1)
	    end
 	end
end
