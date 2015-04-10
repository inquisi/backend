require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data

RSpec.describe User, type: :model do
  it "should require a first and last name" do
    user = build(:user_with_booleans_student, first_name: "", last_name: "")
    expect(user.save).to be false
  end

  it "should require an email" do
    user = build(:user_with_booleans_student, email: "")
    expect(user.save).to be false
  end

  it "should require a unique email" do
    user = create(:user_with_booleans_student, email: "test@test.com")
    user2 = build(:user_with_booleans_student, email: "test@test.com")
    expect(user2.save).to be false
  end

  it "should require a valid email" do
    user = build(:user_with_booleans_student, email: "abcd")
    expect(user.save).to be false
  end

  it "should require a password" do
    user = build(:user_with_booleans_student, password: "")
    expect(user.save).to be false
  end

  it "should generate a uuid token after it has been saved" do
    user = build(:user_with_booleans_student)
    expect(user.token).to eql(nil)
    user.save
    expect(user.token).not_to eql(nil)
  end

  it "should require either a student or instructor" do
    user = build(:user)
    expect(user.save).to be false
  end


end
