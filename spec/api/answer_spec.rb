require 'rails_helper'
#For all Answers
RSpec.describe 'Answer API', type: :request do
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
      pending "Implementation" 
      fail
    end

    it "should return an error if sa_answer creation unsuccessful" do
      pending "Implementation" 
      fail
    end

    it "should return an num_answer confirm json if creation successful" do
      pending "Implementation" 
      fail
    end

    it "should return an error if num_answer creation unsuccessful" do
      pending "Implementation" 
      fail
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
    it 'should return an mc_answer json containing an array of mc_answers that belong to the instructor' do
      pending "Implementation" 
      fail
    end

  end


  describe '/sa_answers/#id' do
    it 'should show the mc_answer corresponding to #id, for a given question_id ' do
      pending "Implementation" 
      fail
    end

  end

  describe '/num_answers' do
    it 'should return an mc_answer json containing an array of mc_answers that belong to the instructor' do
      pending "Implementation" 
      fail
    end

  end


  describe '/num_answers/#id' do
    it 'should show the mc_answer corresponding to #id, for a given question_id ' do
      pending "Implementation" 
      fail
    end

  end

end

