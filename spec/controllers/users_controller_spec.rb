require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data
RSpec.describe UsersController, type: :controller do
  render_views
  describe "signup" do
    it "should take a first name, last name, email, password, role, and password confirmation and create a user record" do
      # attributes_for returns a hash of values as they're defined in factories.rb
      expect {
        post :signup, attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))
      }.to change(User, :count).by(1)
    end
  end
end