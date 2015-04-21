require 'rails_helper'

RSpec.describe McAnswersController, type: :controller do
	describe "create" do
	    it "should take a name, correctness and a question_id and create an answer record" do
	      	# attributes_for returns a hash of values as they're defined in factories.rb
	      	expect {
	     	   post :create , attributes_for(:mc_answer)
	      	}.to change(McAnswer, :count).by(1)
	    end
 	end
end
