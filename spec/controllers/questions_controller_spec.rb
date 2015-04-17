require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe "create" do
	    it "should take a name, category and a  session_id and create a question record" do
	      # attributes_for returns a hash of values as they're defined in factories.rb
	      expect {
	        post :create , attributes_for(:question)
	      }.to change(Question, :count).by(1)
	    end

  	end
end
