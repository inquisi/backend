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

  it "should require an instructor" do
    course = build(:course)
    course.instructors = []
    expect(course.save).to eql(false)
  end
  
  it "should generate a 6 digit enrollment token when it's saved" do
    course = build(:course)
    expect(course.enrollment_token).to be_nil

    course.save!
    expect(course.enrollment_token).to_not be_nil
    expect(course.enrollment_token.to_s.length).to eql 6    
  end
end

