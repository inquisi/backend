require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data

RSpec.describe UsersController, type: :controller do
  describe "signup" do
    it "should take a first name, last name, email, password, and password confirmation and create a user record" do
      # attributes_for returns a hash of values as they're defined in factories.rb
      expect {
        post :signup, attributes_for(:signup_user)
      }.to change(User, :count).by(1)
    end

    it "should set 'current_user' in the session" do
      user = build(:user)
      allow(User).to receive(:create) { user }
      post :signup, attributes_for(:signup_user)
      expect(session['current_user']).to be(user)
    end

    it "should render corret json" do
      user = build(:user)
      allow(User).to receive(:create) { user }
      post :signup, attributes_for(:signup_user)
      expect(response.body).to be(attributes_for(:user).to_json)
    end
  end
end