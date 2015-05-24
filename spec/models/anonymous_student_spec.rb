require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data

RSpec.describe AnonymousStudent, type: :model do
  it "should alias name to first_name" do
    user = create(:anonymous_student, name: "test")
    expect(user.first_name).to eql "test"
  end
end