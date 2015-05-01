require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	
	describe "create" do

	    it "should make a Question record" do
	      expect {
	        post :create , attributes_for(:question)
	      }.to change(Question, :count).by(1)
	    end

  	end

end
