require 'rails_helper'

RSpec.describe Course, type: :model do
  
  it "should require a name" do
    course = build(:course, name: "")
    expect(course.save).to be false
  end

  it "should require a start date" do
    course = build(:course, start: "")
    expect(course.save).to be false
  end

  it "should require a finish date" do
    course = build(:course, finish: "")
    expect(course.save).to be false
  end
  #How to test that has at least instructor????
  
  # it "should require at least one instructor" do
  #   course = build(:course)
  #   expect(course.save).to be false
  # end

  #Other tests 
end

