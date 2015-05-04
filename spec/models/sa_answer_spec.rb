require 'rails_helper'

RSpec.describe SaAnswer, type: :model do
  it "should require a name" do
    answer = build(:saA, name: "")
    expect(answer.save).to be false
  end
  
  it "should require a question_id" do
    answer = build(:saA, question_id: "")
    expect(answer.save).to be false
  end
  
end
