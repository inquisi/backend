require 'rails_helper'

RSpec.describe 'Organization', type: :model do
  it "should require a name" do
    organization = build(:organization, name: "")
    expect(organization.save).to be false
  end
end
