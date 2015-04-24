require 'rails_helper'

RSpec.describe SaAnswer, type: :model do
  it "should require a name" do
    sa_answer = build(:sa_answer, name: "")
    expect(sa_answer.save).to be false
  end
  
  it "should require a question_id" do
    sa_answer = build(:sa_answer, question_id: "")
    expect(sa_answer.save).to be false
  end
end
