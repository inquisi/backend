require 'rails_helper'

RSpec.describe McAnswer, type: :model do
  
  it "should require a name" do
    question = build(:answer, name: "")
    expect(question.save).to be false
  end
  it "should require a order" do
    question = build(:answer, order: "")
    expect(question.save).to be false
  end
  it "should require a correct flag" do
    question = build(:answer, correct: "")
    expect(question.save).to be false
  end
  it "should require a question_id" do
    question = build(:answer, question_id: "")
    expect(question.save).to be false
  end
end