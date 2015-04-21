require 'rails_helper'

RSpec.describe 'Session API', type: :request do
  # render_views



  describe "/create" do
      it "should return a session confirm json if creation successful" do
        post '/sessions', attributes_for(:session)

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("session")
        expect(JSON.parse(response.body)["data"]["session"]).to include("name")
        expect(JSON.parse(response.body)["data"]["session"]).to include("date")
        expect(JSON.parse(response.body)["data"]["session"]).to include("id")
        
      end

      it "should return an error if session creation unsuccessful" do
        session_hash = attributes_for(:session)
        session_hash[:name] = ""
        post '/sessions', session_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a session', data: {}}.to_json)
      end
    
  end



  #Return all students in session (Attendence) -> Other way??
  describe '' do
    it 'should ' do
      
    end
  end

  describe '/sessions' do
    it 'should return a session json containing an array of sessions that belong to the user' do
      user = create(:student_with_courses_with_sessions)
      courses = 
      get '/sessions', token: user.token, course_id: user.courses.first.id

      body = JSON.parse(response.body)
      sessions = body['data']
      session = sessions.first

      expect(sessions.length).to eql(1)
      expect(session['name']).to eql(user.sessions.first.name)
      expect(session['date']).to eql(user.sessions.first.date.to_s)
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

  
  describe '/sessions/#id' do
    # it 'should return the session which has the #id and which the user has access rights to' do
    #   user = create(:student_with_courses_with_sessions)
    #   course = 
    #   get "/sessions/#{course.sessions.first.id}", token: user.token 

    #   body = JSON.parse(response.body)
    #   data = body['data']
    #   session = data['session']
      
    #   expect(session['name']).to eql(user.sessions.first.name)
    #   expect(session['date']).to eql(user.sessions.first.date.to_s)
      
    # end
  end




  
end