require 'rails_helper'

RSpec.describe 'Course API', type: :request do
  # render_views

  describe "/create" do
    it "should return a course token json if creation successful" do
      post '/courses', attributes_for(:course)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("course")
      expect(JSON.parse(response.body)["data"]["course"]).to include("name")
      expect(JSON.parse(response.body)["data"]["course"]).to include("start")
      expect(JSON.parse(response.body)["data"]["course"]).to include("finish")

    end

    it "should return an error if course creation unsuccessful" do
      course_hash = attributes_for(:course)
      course_hash[:name] = ""
      post '/courses', course_hash
      expect(response.body).to eql({status: 'failure', message: 'The course was not created', data: ""}.to_json)
    end
  end

  describe '/courses' do
    it 'should return a course json containing an array of courses that belong to the user' do
      user = create(:user, attributes_for(:user_with_password_confirmation).merge(attributes_for(:student)))
      create :course
      create :course
      create :course

      get '/courses', token: user.token   

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      # Array of courses
      
      expect(JSON.parse(response.body)["data"]["courses"]).to include([attributes_for(:course)])



    end
  end
  # describe '/course/#id or #token' do
  #   it 'should return a course json containing the information of the course token if the user has rights to access it' do
  #     course = create(:course)
  #     get '/courses', token: course.token

  #   end

  # end

end

