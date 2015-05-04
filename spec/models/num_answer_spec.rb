require 'rails_helper'

RSpec.describe NumAnswer, type: :model do
  it "should require a num" do
    answer = build(:numA, num: "")
    expect(answer.save).to be false
  end
  
  it "should require a question_id" do
    answer = build(:numA, question_id: "")
    expect(answer.save).to be false
  end
  
end
