require 'rails_helper'

RSpec.describe McResponse, type: :model do
	it "should require a answer_id" do
	    mc_response = build(:mc_response, answer_id: nil)
	    expect(mc_response.save).to be false
	end
		it "should require a user_id" do
	    mc_response = build(:mc_response, user_id: nil)
	    expect(mc_response.save).to be false
	end

end
