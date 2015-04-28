require 'rails_helper'

RSpec.describe 'User API', type: :request do
  # render_views

  describe "/signup" do
    it "should return a user token json if signup successful" do
      post '/signup', attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))

      student = User.first
      expected_response_data = {
        user: {
          token: student.token,
          first_name: student.first_name,
          last_name: student.last_name,
          email: student.email,
          role: student.role,
          trial: student.trial,
        }
      }

      expect(response.body).to eql({status: 'success', message: '', data: expected_response_data}.to_json)
    end

    it "should return an error if signup unsuccessful" do
      user_hash = attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))
      user_hash[:email] = ""
      post '/signup', user_hash

      expect(response.body).to eql({status: 'failure', message: 'Email is invalid', data: {}}.to_json)
    end
  end

  describe '/login' do
    it 'should return a user token json if login successful' do
      user = create(:student)
      post '/login', attributes_for(:user).extract!(:email, :password)

      student = User.first
      expected_response_data = {
        user: {
          token: student.token,
          first_name: student.first_name,
          last_name: student.last_name,
          email: student.email,
          role: student.role,
          trial: student.trial,
        }
      }

      expect(response.body).to eql({status: 'success', message: '', data: expected_response_data}.to_json)
    end

    it 'should return an error if login unsuccessful' do
      allow(User).to receive(:find_by_email) { nil }
      post '/login', attributes_for(:user).extract!(:email, :password)

      expect(response.body).to eql({status: 'failure', message: 'Email or password is incorrect', data: {}}.to_json)
    end
  end

  describe 'signup and login' do
    it 'should return the same token' do
      user_hash = attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))
      post '/signup', user_hash
      signup_token = JSON.parse(response.body)['data']['user']['token']
      post '/login', attributes_for(:user).extract!(:email, :password)
      login_token = JSON.parse(response.body)['data']['user']['token']

      expect(signup_token).to eql login_token
    end
  end

  describe '/user' do
    it 'should return a student user json if given valid token' do
      user = create(:student)
      get '/user', token: user.token

      user = User.first
      expected_response_data = {
        user: {
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email,
          role: user.role,
          trial: user.trial,
        }
      }

      expect(response.body).to eql({status: 'success', message: '', data: expected_response_data}.to_json)
    end

    it 'should return an instructor user json if given valid token' do
      user = create(:instructor)
      get '/user', token: user.token

      user = User.first
      expected_response_data = {
        user: {
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email,
          role: user.role,
          trial: user.trial,
          organization: user.organization
        }
      }

      expect(response.body).to eql({status: 'success', message: '', data: expected_response_data}.to_json)
      
    end

  end

end