require 'rails_helper'

RSpec.describe 'Question API', type: :request do

  describe "/create" do
      before(:each) do 
        create :instructor_with_courses_with_sessions
        @session = Session.first
      end

      #CREATE EXPECTED SUCCESS
      it "should return a MC question confirm json if creation successful" do
        post '/questions', attributes_for(:mc).merge!({session_id: @session.id})

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")
      end

      it "should return a SA question confirm json if creation successful" do
        post '/questions', attributes_for(:sa).merge!({session_id: @session.id})

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")

      end

      it "should return a NUM question confirm json if creation successful" do
        post '/questions', attributes_for(:num).merge!({session_id: @session.id})

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")

      end      

      it "should return a LA question confirm json if creation successful" do
        post '/questions', attributes_for(:la).merge!({session_id: @session.id})

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("category")
        expect(JSON.parse(response.body)["data"]["question"]).to include("id")

      end

      #EXPECTED ERRORS
      it "should return an error if mc question creation unsuccessful" do
        question_hash = attributes_for(:mc)
        question_hash[:name] = ""
        post '/questions', question_hash.merge!({session_id: @session.id})
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end

      it "should return an error if SA question creation unsuccessful" do
        question_hash = attributes_for(:sa).merge!({session_id: @session.id})
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end

      it "should return an error if NUM question creation unsuccessful" do
        question_hash = attributes_for(:num).merge!({session_id: @session.id})
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end

      it "should return an error if LA question creation unsuccessful" do
        question_hash = attributes_for(:la).merge!({session_id: @session.id})
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end

  end

  # INDEX
  describe "/questions" do
      it 'should return a question json containing an array of questions that belong to the instructor' do
      user = create(:instructor_with_courses_with_sessions_with_questions)
      course = user.courses.first
      session = course.sessions.first

      get '/questions', token: user.token, course_id: course.id, session_id: session.id

      body = JSON.parse(response.body)
      questions = body['data']
      question = questions.first

      expect(questions.length).to eql(1)
      expect(question['name']).to eql(user.courses.first.sessions.first.questions.first.name)
      expect(question['category']).to eql(user.courses.first.sessions.first.questions.first.category)
      
    end

    
    it 'should return an empty array if instructor has no questions' do
      user = create(:instructor_with_courses_with_sessions)
      course = user.courses.first
      session = course.sessions.first

      get '/questions', token: user.token, course_id: course.id, session_id: session.id
      
      body = JSON.parse(response.body)
      questions = body['data']
      question = questions.first

      expect(questions.length).to eql(0)
    end

  end

  #SHOW
  describe "/questions/#id" do
    it 'should return a question json containing a question that belong to the instructor' do
      user = create(:instructor_with_courses_with_sessions_with_questions)
      course = user.courses.first
      session = course.sessions.first
      first_question = session.questions.first

      
      question_id = first_question.id
      get "/questions/#{question_id}", token: user.token

      body = JSON.parse(response.body)
      data = body['data']
      question = data['question']

      expect(question['name']).to eql(first_question.name)
      expect(question['id']).to eql(first_question.id)
      expect(question['category']).to eql(first_question.category)

    end

    it 'should return an array of answers and responses with the question' do
      user = create(:instructor_with_courses_with_sessions_with_questions)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.create!(name: "answer", correct: false, order: 1)
      number = question.id

      get "/questions/#{number}", token: user.token, course_id: course.id, session_id: session.id

      body = JSON.parse(response.body)
      data = body['data']
      q = data['question']

      expect(q['name']).to eql(question.name)
      expect(q['id']).to eql(question.id)
      expect(q['category']).to eql(question.category)
      expect(q['answers']).to eql(['question_id' => answer.question_id, 'name' => answer.name, 'correct' => answer.correct, 'order' => answer.order, 'id' => answer.id])
      expect(q['responses']).to eql([])
    end
  end

  #UPDATE
  describe "/questions/#id" do
    it "should update the question" do
      user = create(:instructor_with_courses_with_sessions_with_questions)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first

      put "/questions/#{question.id}", token: user.token, name: "hello world"
      body = JSON.parse(response.body)
      q = body['data']['question']

      expect(q['name']).to eql('hello world')
    end

  end

  #DELETE
  describe "/questions/#id" do
    it "should delete the question and return a blank success response" do
      user = create(:instructor_with_courses_with_sessions_with_questions)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      

      delete "/questions/#{question.id}", token: user.token
      body = JSON.parse(response.body)

      expect(body['data']).to eql({})
    end

    it "should delete the question and its answers " do 
      instructor = create(:instructor_with_mcA)
      question = instructor.questions.first
      #Delete all answers belonging to user
      delete "/answers", token: instructor.token, question_id: question.id

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

      #Check For question answers
      get '/answers', token: instructor.token, question_id: question.id

      body = JSON.parse(response.body)
      a = body['data']
      expect(a.length).to eql(0)
 
      #Delete question itself
      
      number = question.id
      delete "/questions/#{number}", token: instructor.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
    end
      
      #SPECIAL CASE for laR
    it "should delete the question and its la responses " do 
      user        = create(:instructor_with_laR) 
      #Wierd case becasue students can't own a question, so could not delete 
      course      = user.courses.first
      question    = user.questions.first
      number      = question.id
     

      
      #Delete all answers belonging to user
      delete "/responses", token: user.token, question_id: question.id

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

      #Check For question answers
      get '/responses', token: user.token, question_id: question.id

      body = JSON.parse(response.body)
      a = body['data']
      expect(a.length).to eql(0)
 
      #Delete question itself
      
      delete "/questions/#{number}", token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
    end
      

     

  end

  #ACTIVATE
  describe '/questions/#id/activate' do

    it 'should active the question corresponding to #id' do
      
      user = create(:instructor_with_courses_with_sessions_with_questions)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      number      = question.id

      expect(question.active).to eql(false)

      post "/questions/#{number}/activate", token: user.token, active: true
      body = JSON.parse(response.body)
      q = body['data']['question']

      expect(q['active']).to eql(true)
    end

  end

end