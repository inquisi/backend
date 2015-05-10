require 'rails_helper'

RSpec.describe 'User API', type: :request do 

  describe "/signup" do

    #CREATE EXPECTED SUCCESS
    it "should return a user token json if signup successful" do
      post '/signup', attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("user")
      expect(JSON.parse(response.body)["data"]["user"]).to include("first_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("last_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).to include("role")
      expect(JSON.parse(response.body)["data"]["user"]).to include("trial")
      expect(JSON.parse(response.body)["data"]["user"]).to include("token")
    end

    #EXPECTED ERRORS
    it "should return an error if signup unsuccessful" do
      user_hash = attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))
      user_hash[:email] = ""
      post '/signup', user_hash

      expect(response.body).to eql({status: 'failure', message: 'Email is invalid', data: {}}.to_json)
    end
  end

  describe '/login' do

    #CREATE EXPECTED SUCCESS
    it 'should return a user token json if login successful' do
      user = create(:student)
      post '/login', attributes_for(:user).extract!(:email, :password)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("user")
      expect(JSON.parse(response.body)["data"]["user"]).to include("token")
      expect(JSON.parse(response.body)["data"]["user"]).to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).to include("first_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("last_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("role")
      expect(JSON.parse(response.body)["data"]["user"]).to include("trial")
    end

  #EXPECTED ERRORS
    it 'should return an error if login unsuccessful' do
      allow(User).to receive(:find_by_email) { nil }
      post '/login', attributes_for(:user).extract!(:email, :password)

      expect(response.body).to eql({status: 'failure', message: 'Email or password is incorrect', data: {}}.to_json)
    end
  end

  describe 'signup and login' do

    #CREATE EXPECTED SUCCESS
    it 'should return the same token' do
      user_hash = attributes_for(:user_with_password_confirmation).merge(attributes_for(:student))
      post '/signup', user_hash
      signup_token = JSON.parse(response.body)['data']['user']['token']
      post '/login', attributes_for(:user).extract!(:email, :password)
      login_token = JSON.parse(response.body)['data']['user']['token']

      expect(signup_token).to eql login_token
    end
  end

  #SHOW
  describe '/user' do
    it 'should return a student user json if given valid token' do
      user = create(:student)
      get '/user', token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("user")
      expect(JSON.parse(response.body)["data"]["user"]).to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).to include("first_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("last_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("role")

      expect(JSON.parse(response.body)["data"]["user"]).not_to include("token")
      expect(JSON.parse(response.body)["data"]["user"]).not_to include("organization")

    end

    it 'should return an instructor user json if given valid token' do
      user = create(:instructor)
      get '/user', token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("user")
      expect(JSON.parse(response.body)["data"]["user"]).to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).to include("first_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("last_name")
      expect(JSON.parse(response.body)["data"]["user"]).to include("role")
      expect(JSON.parse(response.body)["data"]["user"]).to include("organization")
      
      expect(JSON.parse(response.body)["data"]["user"]).not_to include("token")
      
    end

  end

  #Students
  describe '/users/students' do

    it 'should show the students who are in the instructors courses' do
      user = create(:instructor_with_courses)
      course = user.courses.first
      course2 = user.courses.new(name: "cs293", start: Date.today, finish: Date.tomorrow)
      s1 = create(:student, email: "test@test.com")
      s2 = create(:student, email: "t@test.com")
      s3 = create(:student, email: "tes@test.com")

      course.students = [s1, s2, s3]
      course2.students = [s1, s3]
      course2.instructors << user
      course.save!
      course2.save!

      get "/user/students", token: user.token

      body = JSON.parse(response.body)
      #Body has an array of students
      s = body['data']
      expect(s.length).to eql(3)
      expect(s[0]['first_name']).to eql(s1.first_name)
      expect(s[0]['email']).to eql(s1.email)
      expect(s[0]['id']).to eql(s1.id)
      expect(s[0]['courses'][0]['id']).to eql(course.id)

    end

  end

  #UPDATE
  describe '/users/#id' do

    it 'should update the user corresponding to #id' do
      
      user = create(:instructor)

      put "/users/#{user.id}", token: user.token, first_name: "bob"

      body = JSON.parse(response.body)
      s = body['data']['user']
      expect(s['first_name']).to eql('bob')

    end

  end 

  #DELETE
  describe '/users/#id' do

    it 'should delete the instructor corresponding to #id' do
      
      user = create(:instructor)

      
      delete "/users", token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

    end



    it 'should delete the student corresponding to #id' do
      
      user = create(:student)
      
      delete "/users/", token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
    end

    
   it 'should delete the instructor and dependencies corresponding to #id' do
      
      user = create(:instructor_with_courses)
      #Delete all courses belonging to user
      delete "/courses", token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

      #Check For user courses
      get '/courses', token: user.token  
      body = JSON.parse(response.body)
      courses = body['data']
      expect(courses.length).to eql(0)

      #Delete User itself
      delete "/users", token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

    end

  end 

end