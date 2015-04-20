require 'rails_helper'

RSpec.describe McResponse, type: :model do
	it "should require a answer_id" do
	    question = build(:mc_answer, answer_id: "")
	    expect(question.save).to be false
	end
		it "should require a user_id" do
	    question = build(:mc_answer, user_id: "")
	    expect(question.save).to be false
	end

end
