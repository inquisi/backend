require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data

RSpec.describe User, type: :model do
  it "should require a first and last name" do
    user = build(:student, first_name: "", last_name: "")
    expect(user.save).to be false
  end

  it "should require an email" do
    user = build(:student, email: "")
    expect(user.save).to be false
  end

  it "should require a unique email" do
    user = create(:student, email: "test@test.com")
    user2 = build(:student, email: "test@test.com")
    expect(user2.save).to be false
  end

  it "should require a valid email" do
    user = build(:student, email: "abcd")
    expect(user.save).to be false
  end

  it "should require a password" do
    user = build(:student, password: "")
    expect(user.save).to be false
  end

  it "should generate a uuid token after it has been saved" do
    user = build(:student)
    expect(user.token).to eql(nil)
    user.save
    expect(user.token).not_to eql(nil)
  end

  it "should require role not to be blank" do
    user = build(:user, role: '')
    expect(user.save).to be false
    expect(user.errors.full_messages.first).to eql "Role is required."
  end

  it "should transform role with correct characters to role with correct characters and capitalization" do
    user = build(:student, role: 'anonymousstudent')
    expect(user.save).to be true
    expect(user.role).to eql "AnonymousStudent"
  end
  
end
