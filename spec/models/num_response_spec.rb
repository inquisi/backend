require 'rails_helper'

RSpec.describe NumResponse, type: :model do
  	it "should require a num_answer_id" do
	    response = build(:numR, num_answer_id: nil)
	    expect(response.save).to be false
	end
	
	it "should require a user_id" do
	    response = build(:numR, user_id: nil)
	    expect(response.save).to be false
	end

	it "should require a num" do
	    response = build(:numR, num: nil)
	    expect(response.save).to be false
	end

end
