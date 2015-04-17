require 'rails_helper'

RSpec.describe Question, type: :model do
  it "should require a name" do
    question = build(:question, name: "")
    expect(question.save).to be false
  end
  it "should require a type" do
    question = build(:question, type: "")
    expect(question.save).to be false
  end



end
