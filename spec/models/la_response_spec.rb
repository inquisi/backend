require 'rails_helper'

RSpec.describe LaResponse, type: :model do
  	it "should require a question_id" do
	    response = build(:laR, question_id: nil)
	    expect(response.save).to be false
	end

	it "should require a user_id" do
	    response = build(:laR, user_id: nil)
	    expect(response.save).to be false
	end

	it "should require a name" do
	    response = build(:laR, name: nil)
	    expect(response.save).to be false
	end

end
