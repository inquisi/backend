require 'rails_helper'

RSpec.describe NumResponse, type: :model do
  	it "should require a num_answer_id" do
	    num_response = build(:num_response, num_answer_id: nil)
	    expect(num_response.save).to be false
	end
	it "should require a user_id" do
	    num_response = build(:num_response, user_id: nil)
	    expect(num_response.save).to be false
	end
	it "should require a num" do
	    num_response = build(:num_response, num: nil)
	    expect(num_response.save).to be false
	end
end
