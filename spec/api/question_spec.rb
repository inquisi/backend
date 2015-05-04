require 'rails_helper'

RSpec.describe 'Question API', type: :request do

  describe "/create" do
      it "should return a MC question confirm json if creation successful" do
        post '/questions', attributes_for(:mc)

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")

      end

      it "should return an error if question creation unsuccessful" do
        question_hash = attributes_for(:mc)
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end
      
      it "should return a SA question confirm json if creation successful" do
        post '/questions', attributes_for(:sa)

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")

      end

      it "should return an error if SA question creation unsuccessful" do
        question_hash = attributes_for(:sa)
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end

      it "should return a NUM question confirm json if creation successful" do
        post '/questions', attributes_for(:num)

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")

      end

      it "should return an error if NUM question creation unsuccessful" do
        question_hash = attributes_for(:num)
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end

      it "should return a LA question confirm json if creation successful" do
        post '/questions', attributes_for(:la)

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")

      end

      it "should return an error if LA question creation unsuccessful" do
        question_hash = attributes_for(:la)
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end

  end

  describe "/questions" do
      it 'should return a question json containing an array of questions that belong to the instructor' do
      user = create(:instructor_with_courses_with_sessions_with_questions)
      get '/questions', token: user.token, course_id: user.courses.first.id, session_id: user.courses.first.sessions.first.id

      body = JSON.parse(response.body)
      questions = body['data']
      question = questions.first

      expect(questions.length).to eql(1)
      expect(question['name']).to eql(user.courses.first.sessions.first.questions.first.name)
      expect(question['category']).to eql(user.courses.first.sessions.first.questions.first.category)
      
    end

    it 'should return a question json containing an array of questions that belong to the student' do
      user = create(:student_with_courses_with_sessions_with_questions)
      get '/questions', token: user.token, course_id: user.courses.first.id, session_id: user.courses.first.sessions.first.id

      body = JSON.parse(response.body)
      questions = body['data']
      question = questions.first

      expect(questions.length).to eql(1)
      expect(question['name']).to eql(user.courses.first.sessions.first.questions.first.name)
      expect(question['category']).to eql(user.courses.first.sessions.first.questions.first.category)

    end

    it 'should return an empty array if student has no questions' do
      user = create(:student_with_courses_with_sessions)
      get '/questions', token: user.token, course_id: user.courses.first.id, session_id: user.courses.first.sessions.first.id

      body = JSON.parse(response.body)
      questions = body['data']
      question = questions.first

      expect(questions.length).to eql(0)
    end
  end

  describe "/questions/#id" do
    it 'should return a question json containing a question that belong to the instructor' do
      user = create(:instructor_with_courses_with_sessions_with_questions)
      course = user.courses.first
      session = course.sessions.first
      first_question = user.courses.first.sessions.first.questions.first
      number = first_question.id
      get "/questions/#{number}", token: user.token, course_id: course.id, session_id: session.id

      body = JSON.parse(response.body)
      data = body['data']
      question = data['question']

      expect(question['name']).to eql(first_question.name)
      expect(question['category']).to eql(first_question.category)
      expect(question['id']).to eql(first_question.id)
      
    end

    it 'should return a question json containing a question that belong to the student' do
      user = create(:student_with_courses_with_sessions_with_questions)
      course = user.courses.first
      session = course.sessions.first
      first_question = user.courses.first.sessions.first.questions.first
      number = first_question.id
      get "/questions/#{number}", token: user.token, course_id: course.id, session_id: session.id

      body = JSON.parse(response.body)
      data = body['data']
      question = data['question']

      expect(question['name']).to eql(first_question.name)
      expect(question['category']).to eql(first_question.category)
      
    end
    
  end

end