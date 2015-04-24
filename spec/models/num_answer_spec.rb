require 'rails_helper'

RSpec.describe NumAnswer, type: :model do
  it "should require a num" do
    num_answer = build(:num_answer, num: "")
    expect(num_answer.save).to be false
  end
  
  it "should require a question_id" do
    num_answer = build(:num_answer, question_id: "")
    expect(num_answer.save).to be false
  end
end
