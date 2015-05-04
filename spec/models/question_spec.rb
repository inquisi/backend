require 'rails_helper'

RSpec.describe Question, type: :model do
  
  #Multiple Choice is default for question tests

  it "should require a name" do
    question = build(:mc, name: "")
    expect(question.save).to be false
  end

  it "should require a category" do
    question = build(:mc, category: "")
    expect(question.save).to be false
  end

  it "should require an active" do
    question = build(:mc, active: "")
    expect(question.save).to be false
  end

  it "should require a session_id" do
    question = build(:mc, session_id: "")
    expect(question.save).to be false
  end

end
