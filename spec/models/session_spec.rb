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

  it "should require an active" do
    session = build(:session, active: "")
    expect(session.save).to be false
  end

  it "should require a course_id" do
    session = build(:session, course_id: "")
    expect(session.save).to be false
  end

  describe "anonymous participation" do
    it "should generate a token if anonymous_participation goes from false to true" do
      session = create(:session)
      expect(session.token).to eql nil
      session.update(allow_anonymous: true)
      expect(session.token).not_to eql nil
    end

    it "should generate a new token if anonymous_participation goes from false to true after a token has previously been generated" do
      session = create(:session, token: "test")
      expect(session.token).to eql "test"
      session.update(allow_anonymous: true)
      expect(session.token).not_to eql "test"
    end
  end
end