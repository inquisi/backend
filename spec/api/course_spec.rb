require 'rails_helper'

RSpec.describe 'Course API', type: :request do
  
  describe "/create" do
    before :each do
      @instructor = create :instructor
      @student = create :student, email: "student@gmail.com"
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
      expect(JSON.parse(response.body)["data"]["course"]).to include("instructor")
      expect(JSON.parse(response.body)["data"]["course"]).to include("enrollment_token")
    end

    #EXPECTED ERRORS
    it "should return an error if course creation unsuccessful" do
      course_hash = attributes_for(:course, token: @instructor.token)
      course_hash[:name] = ""
      post '/courses', course_hash
      expect(response.body).to eql({status: 'failure', message: 'The course was not created', data: {}}.to_json)
    end

    it "should not allow a student to create a course" do
      post '/courses', attributes_for(:course).merge(token: @student.token)
      expect(response.body).to eql({status: 'failure', message: 'Instructor authentication error', data: {}}.to_json)
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
      expect(course['enrollment_token']).to be_nil
    end

    it 'should return the course which has the #id and which the instructor has access rights to' do
      user = create(:instructor_with_courses)
      get "/courses/#{user.courses.first.id}", token: user.token

      body = JSON.parse(response.body)
      data = body['data']
      course = data['course']
      
      expect(course['name']).to eql(user.courses.first.name)
      expect(course['start']).to eql(user.courses.first.start.to_s)
      expect(course['enrollment_token']).not_to be_nil
    end

  end

  #UPDATE
  describe '/courses/#id' do

    it 'should update the course corresponding to #id' do
      #IMPLEMENT
      user = create(:instructor_with_courses)
      course      = user.courses.first

      put "/courses/#{course.id}", token: user.token, name: "hello world"

      body = JSON.parse(response.body)
      c = body['data']['course']
      expect(c['name']).to eql('hello world')
      

    end

  end 

  #DELETE
  describe '/courses/#id' do

    xit 'should delete the course corresponding to #id' do
      #IMPLEMENT
      
      delete "/courses/#{number}"

    end

  end

  describe "/courses/enroll" do
    before :each do
      @instructor1 = create(:instructor_with_courses, email: "jaime1@gmail.com", first_name: "Jaime1")
      @instructor2 = create(:instructor_with_courses, email: "jaime2@gmail.com", first_name: "Jaime2")
      @student = create :student
      @course = @instructor1.courses.first
    end

    it "should return a success response containing the course a student enrolled in on success" do
      course_hash = {
        name: @course.name,
        start: @course.start.to_s,
        finish: @course.finish.to_s,
        id: @course.id,
        instructor: @instructor1.name
      }
      post '/courses/enroll', {token: @student.token, enrollment_token: @course.enrollment_token}

      body = JSON.parse(response.body).deep_symbolize_keys
      
      expect(body).to eql({status: "success", message: "You've been enrolled", data: {course: course_hash}})
    end

    it "should return an empty failure response when given an incorrect enrollment token" do
      post '/courses/enroll', {token: @student.token, enrollment_token: "humbug!"}

      body = JSON.parse(response.body).deep_symbolize_keys
      
      expect(body).to eql({status: "failure", message: "Incorrect enrollment code", data: {}})
    end

    it "should return an empty failure response when an instructor tries to enroll" do
      post '/courses/enroll', {token: @instructor2.token, enrollment_token: @course.enrollment_token}

      body = JSON.parse(response.body).deep_symbolize_keys
      
      expect(body).to eql({status: "failure", message: "Instructors can't enroll in courses", data: {}})
    end
  end

end


