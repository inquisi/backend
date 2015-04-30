require 'rails_helper'
#For all Answers
RSpec.xdescribe 'Answer API', type: :request do
  # For one answer call for all types
  describe "/create" do
    it "should return an mc_answer confirm json if creation successful" do
      post '/mc_answers', attributes_for(:mc_answer)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("mc_answer")
      expect(JSON.parse(response.body)["data"]["mc_answer"]).to include("name")
      expect(JSON.parse(response.body)["data"]["mc_answer"]).to include("correct")
      expect(JSON.parse(response.body)["data"]["mc_answer"]).to include("order")

    end

    it "should return an error if mc_answer creation unsuccessful" do
      mc_answer_hash = attributes_for(:mc_answer)
      mc_answer_hash[:name] = ""
      post '/mc_answers', mc_answer_hash
      expect(response.body).to eql({status: 'failure', message: 'Failed to create a mc_answer', data: {}}.to_json)
    end

    it "should return an sa_answer confirm json if creation successful" do
      post '/sa_answers', attributes_for(:sa_answer)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("sa_answer")
      expect(JSON.parse(response.body)["data"]["sa_answer"]).to include("name")
    end

    it "should return an error if sa_answer creation unsuccessful" do
      sa_answer_hash = attributes_for(:sa_answer)
      sa_answer_hash[:name] = ""
      post '/sa_answers', sa_answer_hash
      expect(response.body).to eql({status: 'failure', message: 'Failed to create a sa_answer', data: {}}.to_json)
    end

    it "should return an num_answer confirm json if creation successful" do
      post '/num_answers', attributes_for(:num_answer)

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("num_answer")
      expect(JSON.parse(response.body)["data"]["num_answer"]).to include("num")
    end

    it "should return an error if num_answer creation unsuccessful" do
      num_answer_hash = attributes_for(:num_answer)
      num_answer_hash[:num] = ""
      post '/num_answers', num_answer_hash
      expect(response.body).to eql({status: 'failure', message: 'Failed to create a num_answer', data: {}}.to_json)
    end

  end

  
  describe '/mc_answers' do
    it 'should return an mc_answer json containing an array of mc_answers that belong to the instructor' do
      user = create(:instructor_with_courses_with_sessions_with_questions_with_mc_answers)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      mc_answer = question.mc_answers.first
      get '/mc_answers', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

      body = JSON.parse(response.body)
      answers = body['data']
      answer = answers.first
      expect(answers.length).to eql(1)
      expect(answer['name']).to eql(mc_answer.name)
      expect(answer['correct']).to eql(mc_answer.correct)
      expect(answer['order']).to eql(mc_answer.order)
    end

  end


  describe '/mc_answers/#id' do
    it 'should show the mc_answer corresponding to #id, for a given question_id ' do
      user = create(:instructor_with_courses_with_sessions_with_questions_with_mc_answers)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      mc_answer = question.mc_answers.first
      number = mc_answer.id
      get "/mc_answers/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

      body = JSON.parse(response.body)
      data = body['data']
      answer = data['mc_answer']

      expect(answer['name']).to eql(mc_answer.name)
      expect(answer['correct']).to eql(mc_answer.correct)
      expect(answer['order']).to eql(mc_answer.order)

    end

  end

  describe '/sa_answers' do
    it 'should return an sa_answer json containing an array of sa_answers that belong to the instructor' do
      user = create(:student_with_courses_with_sessions_with_questions_with_sa_answers)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      sa_answer = question.sa_answers.first
      get '/sa_answers', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

      body = JSON.parse(response.body)
      answers = body['data']
      answer = answers.first
      expect(answers.length).to eql(1)
      expect(answer['name']).to eql(sa_answer.name)
    end

  end


  describe '/sa_answers/#id' do
    it 'should show the sa_answer corresponding to #id, for a given question_id ' do
      user = create(:student_with_courses_with_sessions_with_questions_with_sa_answers)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      sa_answer = question.sa_answers.first
      number = sa_answer.id
      get "/sa_answers/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

      body = JSON.parse(response.body)
      data = body['data']
      answer = data['sa_answer']

      expect(answer['name']).to eql(sa_answer.name)

    end

  end

  describe '/num_answers' do
    it 'should return an num_answer json containing an array of num_answers that belong to the instructor' do
      user = create(:student_with_courses_with_sessions_with_questions_with_num_answers)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      num_answer = question.num_answers.first
      get '/num_answers', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

      body = JSON.parse(response.body)
      answers = body['data']
      answer = answers.first
      expect(answers.length).to eql(1)
      expect(answer['num']).to eql(num_answer.num)
    end

  end


  describe '/num_answers/#id' do
    it 'should show the num_answer corresponding to #id, for a given question_id ' do
      user = create(:student_with_courses_with_sessions_with_questions_with_num_answers)
      course = user.courses.first
      session = course.sessions.first
      question = session.questions.first
      num_answer = question.num_answers.first
      number = num_answer.id
      get "/num_answers/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

      body = JSON.parse(response.body)
      data = body['data']
      answer = data['num_answer']

      expect(answer['num']).to eql(num_answer.num)

    end

  end

end

