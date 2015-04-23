require 'rails_helper'

#For all resposnes
  
RSpec.describe 'Response API', type: :request do
# render_views

describe "/create" do
	it "should return an response confirm json if mc_response creation successful" do
		user 			= create(:instructor_with_courses_with_sessions_with_questions_with_mc_answers)
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

	it "should return an error if answer creation unsuccessful" do
		mc_response_hash = attributes_for(:mc_response)
		mc_response_hash[:user_id] = ""
		post '/mc_responses', mc_response_hash
		expect(response.body).to eql({status: 'failure', message: 'Failed to create a mc_response', data: {}}.to_json)
	end
end

describe "/mc_responses" do
	it 'should return an mc_response json containing an array of mc_responses that belong to the instructor' do
		user = create(:instructor_with_courses_with_sessions_with_questions_with_mc_answers_with_mc_responses)
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
		user = create(:instructor_with_courses_with_sessions_with_questions_with_mc_answers_with_mc_responses)
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

#Indivudual Response cases-> refer to answser for question over whether this is good?
	# describe "/mc_response" do
	# 	it 'should  ' do
 #      		pending "Implementation" 
 #      		fail

 #    	end
	# end

	# describe "/la_response" do
	# 	it 'should ' do
 #      		pending "Implementation" 
 #      		fail

 #    	end
	# end

	# describe "/sa_response" do
	# 	it 'should ' do
 #      		pending "Implementation" 
 #      		fail

 #    	end
	# end

	# describe "/num_response" do
	# 	it 'should ' do
 #      		pending "Implementation" 
 #      		fail

 #    	end
	# end



end