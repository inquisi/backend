require 'rails_helper'

RSpec.describe 'Session API', type: :request do

  describe "/create" do

    #CREATE EXPECTED SUCCESS
      it "should return a session confirm json if creation successful" do
        post '/sessions', attributes_for(:session)

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("session")
        expect(JSON.parse(response.body)["data"]["session"]).to include("name")
        expect(JSON.parse(response.body)["data"]["session"]).to include("date")
        expect(JSON.parse(response.body)["data"]["session"]).to include("id")
        expect(JSON.parse(response.body)["data"]["session"]).to include("active")

      end

      #EXPECTED ERRORS
      it "should return an error if session creation unsuccessful" do
        session_hash = attributes_for(:session)
        session_hash[:name] = ""
        post '/sessions', session_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a session', data: {}}.to_json)
      end
    
  end

  describe '/sessions' do

    #INDEX
    it 'should return a session json containing an array of sessions that belong to the instructor' do
      user = create(:instructor_with_courses_with_sessions)
      course = user.courses.first
      session = course.sessions.first
      get '/sessions', token: user.token, course_id: course.id

      body = JSON.parse(response.body)
      sessions = body['data']
      s = sessions.first

      expect(sessions.length).to eql(1)
      expect(s['name']).to eql(session.name)
      expect(s['date']).to eql(session.date.to_s)
      expect(s['active']).to eql(session.active)
      
    end

    it 'should return a session json containing an array of sessions that belong to the student' do
      user = create(:student_with_courses_with_sessions)
      course = user.courses.first
      session = course.sessions.first
      get '/sessions', token: user.token, course_id: course.id

      body = JSON.parse(response.body)
      sessions = body['data']
      s = sessions.first

      expect(sessions.length).to eql(1)
      expect(s['name']).to eql(session.name)
      expect(s['date']).to eql(session.date.to_s)
      expect(s['active']).to eql(session.active)

    end
  end

  #SHOW
  describe '/sessions/#id' do
    it 'should return a session json containing an array of sessions that belong to the instructor' do
      user = create(:instructor_with_courses_with_sessions)
      course = user.courses.first
      session = course.sessions.first
      get "/sessions/#{session.id}", token: user.token, course_id: course.id

      body = JSON.parse(response.body)
      data = body['data']
      s = data['session']

      expect(s['name']).to eql(session.name)
      expect(s['date']).to eql(session.date.to_s)
      
    end

    it 'should return a session json containing an array of sessions that belong to the student' do
      user = create(:student_with_courses_with_sessions)
      course = user.courses.first
      session = course.sessions.first
      get "/sessions/#{session.id}", token: user.token, course_id: course.id

      body = JSON.parse(response.body)
      data = body['data']
      s = data['session']

      expect(s['name']).to eql(session.name)
      expect(s['date']).to eql(session.date.to_s)
      expect(s['active']).to eql(session.active)
      
    end
  end

  #UPDATE
  describe '/sessions/#id' do

    it 'should update the session corresponding to #id' do
      
      user = create(:instructor_with_courses_with_sessions)
      course      = user.courses.first
      session     = course.sessions.first

      put "/sessions/#{session.id}", token: user.token, name: "hello world"

      body = JSON.parse(response.body)
      s = body['data']['session']
      expect(s['name']).to eql('hello world')

    end

  end 

  #DELETE
  describe '/sessions/#id' do

    it 'should delete the session corresponding to #id' do
      user = create(:instructor_with_courses_with_sessions)
      course = user.courses.first
      session = course.sessions.first
      number = session.id
      delete "/sessions/#{number}", token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
    end

  end 

  #ACTIVATE
  describe '/sessions/#id/activate' do

    it 'should active the session corresponding to #id' do
      
      user = create(:instructor_with_courses_with_sessions)
      course      = user.courses.first
      session     = course.sessions.first

      post "/sessions/#{session.id}/activate", token: user.token, active: true

      body = JSON.parse(response.body)
      s = body['data']['session']
      expect(s['active']).to eql(true)

    end

  end
  
end