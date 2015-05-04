require 'rails_helper'

RSpec.describe 'Course API', type: :request do
  
  describe "/create" do
    before :each do
      @instructor = create :instructor
    end

    #CREATE EXPECTED SUCCESS
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

    #EXPECTED ERRORS
    it "should return an error if course creation unsuccessful" do
      course_hash = attributes_for(:course)
      course_hash[:name] = ""
      post '/courses', course_hash
      expect(response.body).to eql({status: 'failure', message: 'The course was not created', data: {}}.to_json)
    end

  end

  # INDEX
  describe '/courses' do

    it 'should return an array of courses that belong to the instructor' do
      user = create(:instructor_with_courses)
      get '/courses', token: user.token   

      body = JSON.parse(response.body)
      courses = body['data']
      course = courses.first

      expect(courses.length).to eql(1)
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
    end

    it 'should return an array of courses that belong to the student' do
      user = create(:student_with_courses)
      get '/courses', token: user.token   

      body = JSON.parse(response.body)
      courses = body['data']
      course = courses.first

      expect(courses.length).to eql(1)
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
    end

    #Empty Array Tests
    it 'should return an empty array if instructor does not have any courses' do
      user = create(:instructor)
      get '/courses', token: user.token   

      body = JSON.parse(response.body)
      courses = body['data']
      expect(courses.length).to eql(0)
    end

    it 'should return an empty array if student does not have any courses' do
      user = create(:student)
      get '/courses', token: user.token   

      body = JSON.parse(response.body)
      courses = body['data']
      expect(courses.length).to eql(0)
    end

  end

  #SHOW
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

  #UPDATE
  describe '/courses/#id' do

    xit 'should update the course corresponding to #id' do
      #IMPLEMENT
      
      put "/courses/#{number}"

    end

  end 

  #DELETE
  describe '/courses/#id' do

    xit 'should delete the course corresponding to #id' do
      #IMPLEMENT
      
      delete "/courses/#{number}"

    end

  end 

end


