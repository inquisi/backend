require 'rails_helper'
#For all Answers

RSpec.describe 'Answer API', type: :request do
  # For one answer, for all types

  describe "/create" do

    #CREATE EXPECTED SUCCESS

    it "should return an mc_answer confirm json if creation successful" do
      student = create :instructor_with_mcA
      course = student.courses.first
      session = course.sessions.first
      question = session.questions.first
      post '/answers', attributes_for(:mcA, question_id: question.id)
      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("answer")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("name")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("correct")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("order")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("question_id")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("id")

    end

    it "should return an sa_answer confirm json if creation successful" do
      student = create :instructor_with_saA
      course = student.courses.first
      session = course.sessions.first
      question = session.questions.first
      post '/answers', attributes_for(:saA, question_id: question.id)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("answer")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("name")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("question_id")
    end

    it "should return an num_answer confirm json if creation successful" do
      student = create :instructor_with_numA
      course = student.courses.first
      session = course.sessions.first
      question = session.questions.first
      post '/answers', attributes_for(:numA, question_id: question.id)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("answer")
      expect(JSON.parse(response.body)["data"]["answer"]).to include("num")
    end

    it "should la_answer creation successful" do
      #nothing
    end

    #CREATE EXPECTED ERRORS

    it "should return an error if mc_answer creation unsuccessful" do
      student = create :instructor_with_mcA
      course = student.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer_hash = attributes_for(:mcA, question_id: question.id)
      answer_hash[:name] = ""
      post '/answers', answer_hash
      expect(response.body).to eql({status: 'failure', message: 'Failed to create a mc_answer', data: {}}.to_json)
    end

    it "should return an error if sa_answer creation unsuccessful" do
      student = create :instructor_with_saA
      course = student.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer_hash = attributes_for(:saA, question_id: question.id)
      answer_hash[:name] = ""
      post '/answers', answer_hash
      expect(response.body).to eql({status: 'failure', message: 'Failed to create a sa_answer', data: {}}.to_json)
    end

    it "should return an error if num_answer creation unsuccessful" do
      student = create :instructor_with_numA
      course = student.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer_hash = attributes_for(:numA, question_id: question.id)
      answer_hash[:num] = ""
      post '/answers', answer_hash
      expect(response.body).to eql({status: 'failure', message: 'Failed to create a num_answer', data: {}}.to_json)
    end

    it "should la_answer creation unsuccessful" do
      #nothing
    end

  end

  # INDEX
  describe '/answers' do

    it 'should return an mc_answer json containing an array of mc_answers that belong to the instructor' do
      user = create(:instructor_with_mcA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      get '/answers', token: user.token, question_id: question.id

      body = JSON.parse(response.body)
      answers = body['data']
      a = answers.first
      expect(answers.length).to eql(1)
      expect(a['name']).to eql(answer.name)
      expect(a['correct']).to eql(answer.correct)
      expect(a['order']).to eql(answer.order)
    end

    it 'should return an sa_answer json containing an array of sa_answers that belong to the instructor' do
      user = create(:instructor_with_saA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      get '/answers', token: user.token, question_id: question.id

      body = JSON.parse(response.body)
      answers = body['data']
      a = answers.first
      expect(answers.length).to eql(1)
      expect(a['name']).to eql(answer.name) 
    end

    it 'should return an num_answer json containing an array of num_answers that belong to the instructor' do
      user = create(:instructor_with_numA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      get '/answers', token: user.token, question_id: question.id

      body = JSON.parse(response.body)
      answers = body['data']
      a = answers.first
      expect(answers.length).to eql(1)
      expect(a['num']).to eql(answer.num)
    end

    it "should return all la_answers" do
      #nothing
    end

  end

  #SHOW
  describe '/answers/#id' do

    it 'should show the mc_answer corresponding to #id, for a given question_id ' do
      user = create(:instructor_with_mcA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      number = answer.id
      get "/answers/#{number}", token: user.token

      body = JSON.parse(response.body)
      data = body['data']
      a = data['answer']

      expect(a['name']).to eql(answer.name)
      expect(a['correct']).to eql(answer.correct)
      expect(a['order']).to eql(answer.order)
    end

    it 'should show the sa_answer corresponding to #id, for a given question_id ' do
      user = create(:instructor_with_saA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      number = answer.id
      get "/answers/#{number}", token: user.token

      body = JSON.parse(response.body)
      data = body['data']
      a = data['answer']

      expect(a['name']).to eql(answer.name)
    end

    it 'should show the num_answer corresponding to #id, for a given question_id ' do
      user = create(:instructor_with_numA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      number = answer.id
      get "/answers/#{number}", token: user.token

      body = JSON.parse(response.body)
      data = body['data']
      a = data['answer']

      expect(a['num']).to eql(answer.num)
    end

    it 'should la no answer' do
      #nothing
    end

  end

   #UPDATE
  describe '/answers/#id' do
      it 'should update the mc_answer corresponding to #id, for a given question_id ' do
      
      user = create(:instructor_with_mcA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      number = answer.id
      put "/answers/#{number}", token: user.token, name: "Random"


      body = JSON.parse(response.body)
      data = body['data']
      a = data['answer']

      expect(a['name']).to eql("Random")
      expect(a['correct']).to eql(answer.correct)
      expect(a['order']).to eql(answer.order)
    end

    it 'should update the sa_answer corresponding to #id, for a given question_id ' do
      
      user = create(:instructor_with_saA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      number = answer.id
      put "/answers/#{number}", token: user.token, name: "Random"


      body = JSON.parse(response.body)
      data = body['data']
      a = data['answer']

      expect(a['name']).to eql("Random")
    end

    it 'should update the num_answer corresponding to #id, for a given question_id ' do
      
      user = create(:instructor_with_numA)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      answer = question.answers.first
      number = answer.id
      put "/answers/#{number}", token: user.token, num: 53


      body = JSON.parse(response.body)
      data = body['data']
      a = data['answer']

      expect(a['num']).to eql(53)
    end

    it 'should la no answer' do
      #nothing
    end

  end 

  #DELETE
  describe '/answers/#id' do


    it 'should MC answer delete' do
      user = create(:instructor_with_mcA)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      answer      = question.answers.first

      number      = answer.id

      delete "/answers/#{number}", token: user.token
      
      body = JSON.parse(response.body)

      expect(body['data']).to eql({})
      
      

    end

    it 'should SA answer delete' do
      user = create(:instructor_with_saA)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      answer      = question.answers.first
      number      = answer.id

      delete "/answers/#{number}", token: user.token
      
      body = JSON.parse(response.body)

      expect(body['data']).to eql({})

    end

    it 'should NUM answer delete' do
      user = create(:instructor_with_numA)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      answer      = question.answers.first
      number      = answer.id

      delete "/answers/#{number}", token: user.token
      
      body = JSON.parse(response.body)

      expect(body['data']).to eql({})

    end

    it 'should no LA to delete answer' do
      #nothing
    end

  end 

  #DELETE ALL
  #CANT IMPLEMENT UNITL FIX FACTORIES///SEED FILE becuase need access questions, 
  #which students dont have rights too
  describe '/answers' do

    xit 'should MC answer delete and its responses' do
      user = create(:student_with_mcR)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      answer      = question.answers.first
      number      = answer.id

      #Delete all responses belonging to answer
      delete "/responses", token: user.token, mc_answer_id: answer.id

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

      #Check For question answers
      get '/responses', token: user.token, mc_answer_id: answer.id

      body = JSON.parse(response.body)
      a = body['data']
      expect(a.length).to eql(0)

      number = question.id
      delete "/answers/#{number}", token: user.token

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")


    end

    xit 'should SA answer delete and its responses' do
      user = create(:student_with_saR)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      answer      = question.answers.first
      number      = answer.id

      #Delete all responses belonging to answer
      delete "/responses", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

      #Check For question answers
      get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id

      body = JSON.parse(response.body)
      r = body['data']
      expect(r.length).to eql(0)

      number = question.id
      delete "/answers/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

    end

    xit 'should NUM answer delete and its responses' do
      user = create(:student_with_numR)
      course      = user.courses.first
      session     = course.sessions.first
      question    = session.questions.first
      answer      = question.answers.first
      number      = answer.id

      #Delete all responses belonging to answer
      delete "/responses", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

      #Check For question answers
      get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id

      body = JSON.parse(response.body)
      r = body['data']
      expect(r.length).to eql(0)

      number = question.id
      delete "/answers/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")

    end

    it 'should no LA to delete answer' do
      #nothing
    end

  end 

end

