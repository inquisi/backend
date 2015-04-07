require 'rails_helper'

RSpec.describe 'User API', type: :request do
  # render_views

  describe "/signup" do
    it "should return a user token json if signup successful" do
      post '/signup', attributes_for(:user_with_password_confirmation)

      expect(JSON.parse(response.body)["user"]).to include("token")
      expect(JSON.parse(response.body)["user"]).not_to include("email")
      expect(JSON.parse(response.body)["user"]).not_to include("first_name")
    end

    it "should return an error if signup unsuccessful" do
      user_hash = attributes_for(:user_with_password_confirmation)
      user_hash[:email] = ""
      post '/signup', user_hash

      expect(response.body).to eql({errors: {email: ['is invalid']}}.to_json)
    end
  end

  describe '/login' do
    it 'should should return a user token json if login successful' do
      user = create(:user)
      post '/login', attributes_for(:user).extract!(:email, :password)


      expect(JSON.parse(response.body)["user"]).to include("token")
      expect(JSON.parse(response.body)["user"]).not_to include("email")
      expect(JSON.parse(response.body)["user"]).not_to include("first_name")
    end

    it 'should return an error if login unsuccessful' do
      allow(User).to receive(:find_by_email) { nil }
      post '/login', attributes_for(:user).extract!(:email, :password)

      expect(response.body).to eql({errors: {message: "Email or password incorrect"}}.to_json)
    end
  end

end