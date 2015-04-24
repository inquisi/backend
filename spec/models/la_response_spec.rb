require 'rails_helper'

RSpec.describe LaResponse, type: :model do
  it "should require a question_id" do
	    la_response = build(:la_response, question_id: nil)
	    expect(la_response.save).to be false
	end
	it "should require a user_id" do
	    la_response = build(:la_response, user_id: nil)
	    expect(la_response.save).to be false
	end
	it "should require a name" do
	    la_response = build(:la_response, name: nil)
	    expect(la_response.save).to be false
	end
end
