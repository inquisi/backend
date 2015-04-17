require 'rails_helper'

RSpec.describe Question, type: :model do
  it "should require a name" do
    question = build(:question, name: "")
    expect(question.save).to be false
  end
  it "should require a category" do
    question = build(:question, category: "")
    expect(question.save).to be false
  end
  it "should require a session_id" do
    question = build(:question, session_id: "")
    expect(question.save).to be false
  end



end
