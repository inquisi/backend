require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

	describe "create" do

		it "should make a MC ANSWER record" do
	      	expect {
	     	   post :create , attributes_for(:mc_answer)
	      	}.to change(McAnswer, :count).by(1)
	    end

	    it "should make a SA ANSWER record" do
	      	expect {
	     	   post :create , attributes_for(:sa_answer)
	      	}.to change(SaAnswer, :count).by(1)
	    end

	    it "should make a NUM ANSWER record" do
	      	expect {
	     	   post :create , attributes_for(:num_answer)
	      	}.to change(NumAnswer, :count).by(1)
	    end

	    it "should make a LA ANSWER record" do
	      	#Do Nothing
	    end

 	end

end
