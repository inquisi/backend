require 'rails_helper'

#For all resposnes
  
RSpec.describe 'Response API', type: :request do
# render_views

describe "/create" do
	it "should return an response confirm json if mc_response creation successful" do
		user 			= create(:instructor_with_mc_answers)
		course 			= user.courses.first
		session 		= course.sessions.first
		question 		= session.questions.first
		mc_answer 		= question.mc_answers.first
		post '/mc_responses', user_id: user.id, mc_answer_id: mc_answer.id

		expect(JSON.parse(response.body)).to include("status")
		expect(JSON.parse(response.body)).to include("message")
		expect(JSON.parse(response.body)).to include("data")
		expect(JSON.parse(response.body)["data"]).to include("mc_response")
        expect(JSON.parse(response.body)["data"]["mc_response"]).to include("token")
        expect(JSON.parse(response.body)["data"]["mc_response"]).to include("created_at")
		

	end

	it "should return an error if mc response creation unsuccessful" do
		mc_response_hash = attributes_for(:mc_response)
		mc_response_hash[:user_id] = ""
		post '/mc_responses', mc_response_hash
		expect(response.body).to eql({status: 'failure', message: 'Failed to create a mc_response', data: {}}.to_json)
	end

	it "should return an response confirm json if la_response creation successful" do
		user 			= create(:student_with_la_responses)
		course 			= user.courses.first
		session 		= course.sessions.first
		question 		= session.questions.first
		la_response 	= question.la_responses.first
		post '/la_responses', user_id: user.id, question_id: question.id, name: "name"

		expect(JSON.parse(response.body)).to include("status")
		expect(JSON.parse(response.body)).to include("message")
		expect(JSON.parse(response.body)).to include("data")
		expect(JSON.parse(response.body)["data"]).to include("la_response")
		expect(JSON.parse(response.body)["data"]["la_response"]).to include("token")
        expect(JSON.parse(response.body)["data"]["la_response"]).to include("name")
		
	end

	it "should return an error if la response creation unsuccessful" do
		la_response_hash = attributes_for(:la_response)
		la_response_hash[:user_id] = ""
		post '/la_responses', la_response_hash
		expect(response.body).to eql({status: 'failure', message: 'Failed to create a la_response', data: {}}.to_json)
	end

	it "should return an response confirm json if sa_response creation successful" do
		user 			= create(:student_with_sa_answers)
		course 			= user.courses.first
		session 		= course.sessions.first
		question 		= session.questions.first
		sa_answer 		= question.sa_answers.first
		post '/sa_responses', user_id: user.id, sa_answer_id: sa_answer.id, name: "1"

		expect(JSON.parse(response.body)).to include("status")
		expect(JSON.parse(response.body)).to include("message")
		expect(JSON.parse(response.body)).to include("data")
		expect(JSON.parse(response.body)["data"]).to include("sa_response")
		expect(JSON.parse(response.body)["data"]["sa_response"]).to include("token")
        expect(JSON.parse(response.body)["data"]["sa_response"]).to include("name")
	end

	it "should return an error if sa response creation unsuccessful" do
		sa_response_hash = attributes_for(:sa_response)
		sa_response_hash[:user_id] = ""
		post '/sa_responses', sa_response_hash
		expect(response.body).to eql({status: 'failure', message: 'Failed to create a sa_response', data: {}}.to_json)
	end

	it "should return an response confirm json if num_response creation successful" do
		user 			= create(:student_with_num_answers)
		course 			= user.courses.first
		session 		= course.sessions.first
		question 		= session.questions.first
		num_answer 		= question.num_answers.first
		post '/num_responses', user_id: user.id, num_answer_id: num_answer.id, num: 1

		expect(JSON.parse(response.body)).to include("status")
		expect(JSON.parse(response.body)).to include("message")
		expect(JSON.parse(response.body)).to include("data")
		expect(JSON.parse(response.body)["data"]).to include("num_response")
		expect(JSON.parse(response.body)["data"]["num_response"]).to include("token")
        expect(JSON.parse(response.body)["data"]["num_response"]).to include("num")
       
	end

	it "should return an error if num_response creation unsuccessful" do
		num_response_hash = attributes_for(:num_response)
		num_response_hash[:user_id] = ""
		post '/num_responses', num_response_hash
		expect(response.body).to eql({status: 'failure', message: 'Failed to create a num_response', data: {}}.to_json)
	end

end

describe "/mc_responses" do
	it 'should return an mc_response json containing an array of mc_responses that belong to the instructor' do
		user = create(:instructor_with_mc_answers_with_mc_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		mc_answer = question.mc_answers.first
		mc_responses = mc_answer.mc_responses
		mc_response = mc_responses.first
		get '/mc_responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, mc_answer_id: mc_answer.id

		body = JSON.parse(response.body)
		responses = body['data']

		expect(responses.length).to eql(1)

		response = responses.first
		
		expect(response['token']).to eql(user.token)
   		expect(response['created_at']).to eql(mc_response.created_at.to_s)
    
	end
end

describe "/mc_responses/#id" do
	#Is id the response id?
	it 'should show the mc_response corresponding to #id, for a given answer_id ' do
		user = create(:instructor_with_mc_answers_with_mc_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		mc_answer = question.mc_answers.first
		mc_response = mc_answer.mc_responses.first
		number = mc_response.id
		get "/mc_responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, mc_answer_id: mc_answer.id

		#If works
		body = JSON.parse(response.body)
		
		data = body['data']
    	response = data['mc_response']

		expect(response['token']).to eql(user.token)
   		expect(response['created_at']).to eql(mc_response.created_at.to_s)
		
	end
end

describe "/la_responses" do
	it 'should return an la_response json containing an array of la_responses that belong to the instructor' do
  		user = create(:student_with_la_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		la_response  = question.la_responses.first
		get '/la_responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id 

		body = JSON.parse(response.body)
		responses = body['data']

		expect(responses.length).to eql(1)

		response = responses.first
		
		expect(response['token']).to eql(user.token)
		expect(response['name']).to eql(la_response.name)
   		expect(response['created_at']).to eql(la_response.created_at.to_s)

	end
end
describe "/la_responses/#id" do
	it 'should show the la_response corresponding to #id, for a given answer_id' do
  		user = create(:student_with_la_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		la_response = question.la_responses.first
		number = la_response.id
		get "/la_responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

		#If works
		body = JSON.parse(response.body)
		
		data = body['data']
    	response = data['la_response']

		expect(response['token']).to eql(user.token)
		expect(response['name']).to eql(la_response.name)
   		expect(response['created_at']).to eql(la_response.created_at.to_s)

	end
end

describe "/sa_responses" do
	it 'should return an sa_response json containing an array of sa_responses that belong to the instructor' do
  		user = create(:student_with_sa_answers_with_sa_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		sa_answer = question.sa_answers.first
		sa_responses = sa_answer.sa_responses
		sa_response = sa_responses.first
		get '/sa_responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: sa_answer.id

		body = JSON.parse(response.body)
		responses = body['data']

		expect(responses.length).to eql(1)

		response = responses.first
		
		expect(response['token']).to eql(user.token)
		expect(response['name']).to eql(sa_response.name)
   		expect(response['created_at']).to eql(sa_response.created_at.to_s)

	end
end
describe "/sa_responses/#id" do
	it 'should show the sa_response corresponding to #id, for a given answer_id' do
  		user = create(:student_with_sa_answers_with_sa_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		sa_answer = question.sa_answers.first
		sa_response = sa_answer.sa_responses.first
		number = sa_response.id
		get "/sa_responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: sa_answer.id

		#If works
		body = JSON.parse(response.body)
		
		data = body['data']
    	response = data['sa_response']

    	expect(response['token']).to eql(user.token)
		expect(response['name']).to eql(sa_response.name)
   		expect(response['created_at']).to eql(sa_response.created_at.to_s)
		
	end
end

describe "/num_responses" do
	it 'should return an num_response json containing an array of num_responses that belong to the instructor' do
  		user = create(:student_with_num_answers_with_num_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		num_answer = question.num_answers.first
		num_responses = num_answer.num_responses
		num_response = num_responses.first
		get '/num_responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: num_answer.id

		body = JSON.parse(response.body)
		responses = body['data']

		expect(responses.length).to eql(1)

		response = responses.first
		
		expect(response['token']).to eql(user.token)
		expect(response['num']).to eql(num_response.num)
   		expect(response['created_at']).to eql(num_response.created_at.to_s)

	end
end
describe "/num_responses/#id" do
	it 'should show the num_response corresponding to #id, for a given answer_id' do
  		user = create(:student_with_num_answers_with_num_responses)
		course = user.courses.first
		session = course.sessions.first
		question = session.questions.first
		num_answer = question.num_answers.first
		num_response = num_answer.num_responses.first
		number = num_response.id
		get "/num_responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: num_answer.id

		#If works
		body = JSON.parse(response.body)
		
		data = body['data']
    	response = data['num_response']

    	expect(response['token']).to eql(user.token)
		expect(response['num']).to eql(num_response.num)
   		expect(response['created_at']).to eql(num_response.created_at.to_s)

	end
end

end