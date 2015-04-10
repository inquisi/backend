require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data

RSpec.describe UsersController, type: :controller do
  render_views
  describe "signup" do
    it "should take a first name, last name, email, password, role, and password confirmation and create a user record" do
      # attributes_for returns a hash of values as they're defined in factories.rb
      expect {
        post :signup, attributes_for(:user_with_password_confirmation).merge(attributes_for(:user_with_role_student))
      }.to change(User, :count).by(1)
    end
  end

  # Logging in simply involves retrieving database information
  # describe "login" do
  #
  # end

  # describe "logout" do
  #   it 'should ' do
  #
  #   end
  # end
end