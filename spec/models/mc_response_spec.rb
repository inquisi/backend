require 'rails_helper'

RSpec.describe McResponse, type: :model do
	it "should require a mc_answer_id" do
	    response = build(:mcR, mc_answer_id: nil)
	    expect(response.save).to be false
	end

	it "should require a user_id" do
	    response = build(:mcR, user_id: nil)
	    expect(response.save).to be false
	end

end
