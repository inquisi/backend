require 'rails_helper'

RSpec.describe 'User API', type: :request do
  # render_views

  describe "/signup" do
    it "should return a user token json if signup successful" do
      post '/signup', attributes_for(:user_with_password_confirmation).merge(attributes_for(:user_with_role_student))

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("user")
      expect(JSON.parse(response.body)["data"]["user"]).to include("token")

      expect(JSON.parse(response.body)["data"]["user"]).not_to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).not_to include("first_name")
    end

    it "should return an error if signup unsuccessful" do
      user_hash = attributes_for(:user_with_password_confirmation).merge(attributes_for(:user_with_role_student))
      user_hash[:email] = ""
      post '/signup', user_hash

      expect(response.body).to eql({status: 'failure', message: 'Email is invalid', data: ""}.to_json)
    end
  end

  describe '/login' do
    it 'should should return a user token json if login successful' do
      user = create(:user_with_booleans_student)
      post '/login', attributes_for(:user).extract!(:email, :password)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("user")
      expect(JSON.parse(response.body)["data"]["user"]).to include("token")

      expect(JSON.parse(response.body)["data"]["user"]).not_to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).not_to include("first_name")
    end

    it 'should return an error if login unsuccessful' do
      allow(User).to receive(:find_by_email) { nil }
      post '/login', attributes_for(:user).extract!(:email, :password)

      expect(response.body).to eql({status: 'failure', message: 'Email or password is incorrect', data: ""}.to_json)
    end
  end

end