require 'rails_helper'

RSpec.describe Course, type: :model do
  
  it "should require a name" do
    course = build(:course, name: "")
    expect(course.save).to be false
  end

  it "should require a time" do
    course = build(:course, time: "")
    expect(course.save).to be false
  end

  it "should require a user_id" do
    course = build(:course, user_id: "")
    expect(course.save).to be false
  end

  #Other tests 
end

