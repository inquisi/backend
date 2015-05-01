require 'rails_helper'

#For all resposnes
  
RSpec.describe 'Response API', type: :request do

	describe "/create" do

		#EXPECTED SUCCESSES

		it "should  mc_response creation successful" do
			user 			= create(:instructor_with_mcR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			mc_answer 		= question.mc_answers.first
			post '/responses', user_id: user.id, mc_answer_id: mc_answer.id

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("created_at")
		end

		it "should sa_response creation successful" do
			user 			= create(:student_with_saR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			sa_answer 		= question.sa_answers.first
			post '/responses', user_id: user.id, sa_answer_id: sa_answer.id, name: "1"

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
			expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("name")
		end

		it "should num_response creation successful" do
			user 			= create(:student_with_numR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			num_answer 		= question.num_answers.first
			post '/responses', user_id: user.id, num_answer_id: num_answer.id, num: 1

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
			expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("num")
	    end

		it "should la_response creation successful" do
			user 			= create(:student_with_laR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			la_response 	= question.la_responses.first
			post '/responses', user_id: user.id, question_id: question.id, name: "name"

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
			expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("name")
		end

		#EXPECTED ERRORS

		it "should mc response creation unsuccessful" do
			mc_response_hash = attributes_for(:mcR)
			mc_response_hash[:user_id] = ""
			post '/responses', mc_response_hash
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a mc_response', data: {}}.to_json)
		end

		it "should sa response creation unsuccessful" do
			sa_response_hash = attributes_for(:saR)
			sa_response_hash[:user_id] = ""
			post '/responses', sa_response_hash
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a sa_response', data: {}}.to_json)
		end

		it "should num_response creation unsuccessful" do
			num_response_hash = attributes_for(:numR)
			num_response_hash[:user_id] = ""
			post '/responses', num_response_hash
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a num_response', data: {}}.to_json)
		end

		it "should la response creation unsuccessful" do
			la_response_hash = attributes_for(:laR)
			la_response_hash[:user_id] = ""
			post '/responses', la_response_hash
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a la_response', data: {}}.to_json)
		end

	end

	describe "/responses" do

		it 'should  an array of mc_responses that belong to the instructor' do
			user = create(:instructor_with_mcR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			mc_answer = question.mc_answers.first
			mc_responses = mc_answer.mc_responses
			mc_response = mc_responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, mc_answer_id: mc_answer.id

			body = JSON.parse(response.body)
			responses = body['data']

			expect(responses.length).to eql(1)

			response = responses.first
			
			expect(response['token']).to eql(user.token)
	   		expect(response['created_at']).to eql(mc_response.created_at.to_s)
		end

		it 'should  an array of sa_responses that belong to the instructor' do
	  		user = create(:student_with_saR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			sa_answer = question.sa_answers.first
			sa_responses = sa_answer.sa_responses
			sa_response = sa_responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: sa_answer.id

			body = JSON.parse(response.body)
			responses = body['data']

			expect(responses.length).to eql(1)

			response = responses.first
			
			expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(sa_response.name)
	   		expect(response['created_at']).to eql(sa_response.created_at.to_s)
		end

		it 'should an array of num_responses that belong to the instructor' do
	  		user = create(:student_with_numR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			num_answer = question.num_answers.first
			num_responses = num_answer.num_responses
			num_response = num_responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: num_answer.id

			body = JSON.parse(response.body)
			responses = body['data']

			expect(responses.length).to eql(1)

			response = responses.first
			
			expect(response['token']).to eql(user.token)
			expect(response['num']).to eql(num_response.num)
	   		expect(response['created_at']).to eql(num_response.created_at.to_s)
		end

		it 'should an array of la_responses that belong to the instructor' do
	  		user = create(:student_with_LaR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			la_response  = question.la_responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id 

			body = JSON.parse(response.body)
			responses = body['data']

			expect(responses.length).to eql(1)

			response = responses.first
			
			expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(la_response.name)
	   		expect(response['created_at']).to eql(la_response.created_at.to_s)
		end

	end

	describe "/responses/#id" do

		it 'should show the mc_response ' do
			user = create(:instructor_with_mcR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			mc_answer = question.mc_answers.first
			mc_response = mc_answer.mc_responses.first
			number = mc_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, mc_answer_id: mc_answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

			expect(response['token']).to eql(user.token)
	   		expect(response['created_at']).to eql(mc_response.created_at.to_s)
			
		end

		it 'should show the sa_response' do
	  		user = create(:student_with_saR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			sa_answer = question.sa_answers.first
			sa_response = sa_answer.sa_responses.first
			number = sa_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: sa_answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(sa_response.name)
	   		expect(response['created_at']).to eql(sa_response.created_at.to_s)
		end

		it 'should show the num_response' do
	  		user = create(:student_with_numR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			num_answer = question.num_answers.first
			num_response = num_answer.num_responses.first
			number = num_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: num_answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['num']).to eql(num_response.num)
	   		expect(response['created_at']).to eql(num_response.created_at.to_s)
		end

		it 'should show the la_response' do
	  		user = create(:student_with_laR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			la_response = question.la_responses.first
			number = la_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

			expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(la_response.name)
	   		expect(response['created_at']).to eql(la_response.created_at.to_s)
		end

	end

end