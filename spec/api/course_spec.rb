require 'rails_helper'

RSpec.describe 'Course API', type: :request do
  # describe "/create" do
  #   it "should return a course token json if creation successful" do
  #     post '/courses', attributes_for(:course)

  #     expect(JSON.parse(response.body)).to include("status")
  #     expect(JSON.parse(response.body)).to include("message")
  #     expect(JSON.parse(response.body)).to include("data")
  #     expect(JSON.parse(response.body)["data"]).to include("course")
  #     expect(JSON.parse(response.body)["data"]["course"]).to include("name")
  #     expect(JSON.parse(response.body)["data"]["course"]).to include("start")
  #     expect(JSON.parse(response.body)["data"]["course"]).to include("finish")

  #   end

  #   it "should return an error if course creation unsuccessful" do
  #     course_hash = attributes_for(:course)
  #     course_hash[:name] = ""
  #     post '/courses', course_hash
  #     expect(response.body).to eql({status: 'failure', message: 'The course was not created', data: ""}.to_json)
  #   end
  # end

  describe '/courses' do
    it 'should return a course json containing an array of courses that belong to the user' do
      user = create(:student_with_courses)
      get '/courses', token: user.token   

      body = JSON.parse(response.body)
      courses = body['data']
      course = courses.first

      expect(courses.length).to eql(1)
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
    end
  end
  # describe '/course/#id or #token' do
  #   it 'should return a course json containing the information of the course token if the user has rights to access it' do
  #     course = create(:course)
  #     get '/courses', token: course.token

  #   end

  # end

end

