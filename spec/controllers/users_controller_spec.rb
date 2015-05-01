require 'rails_helper'

# use factory_girl and 'factories.rb' to generate test data
RSpec.describe UsersController, type: :controller do

  describe "signup" do

    it "should make a user record" do
      
      expect {
        post :signup, attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))
      }.to change(User, :count).by(1)
    end

  end

end