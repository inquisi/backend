require 'rails_helper'

RSpec.describe McAnswer, type: :model do
  
  it "should require a name" do
    answer = build(:mcA, name: "")
    expect(answer.save).to be false
  end

  it "should require a order" do
    answer = build(:mcA, order: "")
    expect(answer.save).to be false
  end

  it "should require a correct flag" do
    answer = build(:mcA, correct: "")
    expect(answer.save).to be false
  end

  it "should require a question_id" do
    answer = build(:mcA, question_id: "")
    expect(answer.save).to be false
  end
end