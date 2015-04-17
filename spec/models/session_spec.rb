require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data

RSpec.describe Session, type: :model do
  it "should require a name" do
    session = build(:session, name: "")
    expect(session.save).to be false
  end

  it "should require a date" do
    session = build(:session, date: "")
    expect(session.save).to be false
  end

  it "should require a course_id" do
    session = build(:session, course_id: "")
    expect(session.save).to be false
  end

end