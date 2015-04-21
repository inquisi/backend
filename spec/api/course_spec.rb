require 'rails_helper'

RSpec.describe 'Course API', type: :request do
  describe "/create" do
    before :each do
      @instructor = create :instructor
    end

    it "should return a course json if creation successful" do
      post '/courses', attributes_for(:course).merge(token: @instructor.token)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("course")
      expect(JSON.parse(response.body)["data"]["course"]).to include("name")
      expect(JSON.parse(response.body)["data"]["course"]).to include("start")
      expect(JSON.parse(response.body)["data"]["course"]).to include("finish")
      expect(JSON.parse(response.body)["data"]["course"]).to include("id")
    end

    it "should return an error if course creation unsuccessful" do
      course_hash = attributes_for(:course)
      course_hash[:name] = ""
      post '/courses', course_hash
      expect(response.body).to eql({status: 'failure', message: 'The course was not created', data: {}}.to_json)
    end
  end

  describe '/courses' do
    it 'should return a course json containing an array of courses that belong to the student' do
      user = create(:student_with_courses)
      get '/courses', token: user.token   

      body = JSON.parse(response.body)
      courses = body['data']
      course = courses.first

      expect(courses.length).to eql(1)
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
    end

    it 'should return a course json containing an array of courses that belong to the instructor' do
      user = create(:instructor_with_courses)
      get '/courses', token: user.token   

      body = JSON.parse(response.body)
      courses = body['data']
      course = courses.first

      expect(courses.length).to eql(1)
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
    end

  end

  #Return all students in course
  describe '' do
    it 'should ' do
      
    end
  end


  describe '/courses/#id' do
    it 'should return the course which has the #id and which the student has access rights to' do
      user = create(:student_with_courses)
      get "/courses/#{user.courses.first.id}", token: user.token

      body = JSON.parse(response.body)
      data = body['data']
      course = data['course']
      
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
      
    end

    it 'should return the course which has the #id and which the instructor has access rights to' do
      user = create(:instructor_with_courses)
      get "/courses/#{user.courses.first.id}", token: user.token

      body = JSON.parse(response.body)
      data = body['data']
      course = data['course']
      
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
      
    end

  end

  describe '' do
    it 'should ' do
      
    end
  end
 

end

