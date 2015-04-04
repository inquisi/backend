require 'rails_helper'

RSpec.describe 'User API', type: :request do
  # render_views

  describe "/signup" do
    it "should return a user json if signup successful" do
      post '/signup', attributes_for(:user_with_password_confirmation)

      user_without_token_json = JSON.parse(response.body)["user"].except("token").to_json
      expect(user_without_token_json).to eql(attributes_for(:user).except(:password).to_json)
    end

    it "should return an error if signup unsuccessful" do
      user_hash = attributes_for(:user_with_password_confirmation)
      user_hash[:email] = ""
      post '/signup', user_hash

      expect(response.body).to eql({errors: {email: ['is invalid']}}.to_json)
    end
  end

  describe '/login' do
    it 'should should return a user json if login successful' do
      user = create(:user)
      post '/login', attributes_for(:user).extract!(:email, :password)

      user_without_token_json = JSON.parse(response.body)["user"].except("token").to_json
      expect(user_without_token_json).to eql(attributes_for(:user).except(:password).to_json)
    end

    it 'should return an error if login unsuccessful' do
      allow(User).to receive(:find_by_email) { nil }
      post '/login', attributes_for(:user).extract!(:email, :password)

      expect(response.body).to eql({errors: {message: "Email or password incorrect"}}.to_json)
    end
  end

end