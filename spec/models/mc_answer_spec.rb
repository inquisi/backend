require 'rails_helper'

RSpec.describe McAnswer, type: :model do
  
  it "should require a name" do
    mc_answer = build(:mc_answer, name: "")
    expect(mc_answer.save).to be false
  end
  it "should require a order" do
    mc_answer = build(:mc_answer, order: "")
    expect(mc_answer.save).to be false
  end
  it "should require a correct flag" do
    mc_answer = build(:mc_answer, correct: "")
    expect(mc_answer.save).to be false
  end
  it "should require a question_id" do
    mc_answer = build(:mc_answer, question_id: "")
    expect(mc_answer.save).to be false
  end
end