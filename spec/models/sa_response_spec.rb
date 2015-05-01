require 'rails_helper'

RSpec.describe SaResponse, type: :model do
  	it "should require a sa_answer_id" do
	    response = build(:saR, sa_answer_id: nil)
	    expect(response.save).to be false
	end

	it "should require a user_id" do
	    response = build(:saR, user_id: nil)
	    expect(response.save).to be false
	end

	it "should require a name" do
	    response = build(:saR, name: nil)
	    expect(response.save).to be false
	end

end
