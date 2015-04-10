require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "should have a name" do
    Organization = build(:organization)
    expect(Organization.name).eql? "Inquisi"
  end
end
