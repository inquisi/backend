require 'rails_helper'

RSpec.describe SaResponse, type: :model do
  	it "should require a sa_answer_id" do
	    sa_response = build(:sa_response, sa_answer_id: nil)
	    expect(sa_response.save).to be false
	end
	it "should require a user_id" do
	    sa_response = build(:sa_response, user_id: nil)
	    expect(sa_response.save).to be false
	end
	it "should require a name" do
	    sa_response = build(:sa_response, name: nil)
	    expect(sa_response.save).to be false
	end
end
