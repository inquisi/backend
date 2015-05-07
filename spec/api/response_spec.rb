require 'rails_helper'

#For all resposnes

RSpec.describe 'Response API', type: :request do
	before :each do
		Timecop.freeze(Time.local(1990))
	end

	after do
	    Timecop.return
	end
	
	describe "/create" do

		#EXPECTED SUCCESSES

		it "should  mc_response creation successful" do
			user 			= create(:student_with_mcR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			answer 			= question.answers.first
			post '/responses', user_id: user.id, mc_answer_id: answer.id, question_id: question.id

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("created_at")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("answer_id")
		end

		it "should sa_response creation successful" do
			user 			= create(:student_with_saR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			answer 			= question.answers.first
			post '/responses', user_id: user.id, sa_answer_id: answer.id, question_id: question.id, name: "1"

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
			expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("name")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("created_at")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("answer_id")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("correct")
		end

		it "should num_response creation successful" do
			user 			= create(:student_with_numR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			answer 			= question.answers.first
			post '/responses', user_id: user.id, num_answer_id: answer.id, question_id: question.id, num: 1

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
			expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("num")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("created_at")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("answer_id")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("correct")
	    end

		it "should la_response creation successful" do
			user 			= create(:student_with_laR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			post '/responses', user_id: user.id, question_id: question.id, name: "name"

			expect(JSON.parse(response.body)).to include("status")
			expect(JSON.parse(response.body)).to include("message")
			expect(JSON.parse(response.body)).to include("data")
			expect(JSON.parse(response.body)["data"]).to include("response")
			expect(JSON.parse(response.body)["data"]["response"]).to include("token")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("name")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("created_at")
	        expect(JSON.parse(response.body)["data"]["response"]).to include("question_id")
		end

		#EXPECTED ERRORS

		it "should mc response creation unsuccessful" do
			user 			= create(:student_with_mcR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			answer 			= question.answers.first
			post '/responses', user_id: nil, mc_answer_id: answer.id, question_id: question.id
			
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a mc_response', data: {}}.to_json)
		end

		it "should sa response creation unsuccessful" do
			user 			= create(:student_with_saR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			answer 			= question.answers.first
			post '/responses', user_id: nil, sa_answer_id: answer.id, question_id: question.id
			
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a sa_response', data: {}}.to_json)
		end

		it "should num_response creation unsuccessful" do
			user 			= create(:student_with_numR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			answer 			= question.answers.first
			post '/responses', user_id: nil, num_answer_id: answer.id, question_id: question.id
			
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a num_response', data: {}}.to_json)
		end

		it "should la response creation unsuccessful" do
			user 			= create(:student_with_laR)
			course 			= user.courses.first
			session 		= course.sessions.first
			question 		= session.questions.first
			post '/responses', user_id: nil, name: "yi", question_id: question.id
			
			expect(response.body).to eql({status: 'failure', message: 'Failed to create a la_response', data: {}}.to_json)
		end

	end

	#INDEX
	describe "/responses" do

		it 'should return an array of mc_responses that belong to the instructor' do
			user = create(:student_with_mcR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			responses = answer.responses
			mc_response = responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, mc_answer_id: answer.id
			
			body = JSON.parse(response.body)
			rs = body['data']

			expect(rs.length).to eql(1)

			r = rs.first
			
			expect(r['token']).to eql(user.token)
	   		expect(r['created_at']).to eql(mc_response.created_at.round.utc.to_s)
		end

		it 'should return an array of sa_responses that belong to the instructor' do
	  		user = create(:student_with_saR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			responses = answer.responses
			sa_response = responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id

			body = JSON.parse(response.body)
			responses = body['data']

			expect(responses.length).to eql(1)

			response = responses.first
			
			expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(sa_response.name)
	   		expect(response['created_at'].to_s).to eql(sa_response.created_at.round.utc.to_s)
		end

		it 'should return an array of num_responses that belong to the instructor' do
	  		user = create(:student_with_numR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			responses = answer.responses
			num_response = responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id

			body = JSON.parse(response.body)
			responses = body['data']

			expect(responses.length).to eql(1)

			response = responses.first
			
			expect(response['token']).to eql(user.token)
			expect(response['num']).to eql(num_response.num)
	   		expect(response['created_at']).to eql(num_response.created_at.round.utc.to_s)
		end

		it 'should return an array of la_responses that belong to the instructor' do
	  		user = create(:student_with_laR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			la_response  = question.responses.first
			get '/responses', token: user.token, course_id: course.id, session_id: session.id, question_id: question.id 

			body = JSON.parse(response.body)
			responses = body['data']

			expect(responses.length).to eql(1)

			response = responses.first
			
			expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(la_response.name)
	   		expect(response['created_at'].to_s).to eql(la_response.created_at.round.utc.to_s)
		end

	end

	#SHOW
	describe "/responses/#id" do

		it 'should show the mc_response ' do
			user = create(:student_with_mcR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			mc_response = answer.responses.first
			number = mc_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, mc_answer_id: answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	r = data['response']

			expect(r['token']).to eql(user.token)
	   		expect(r['created_at'].to_s).to eql(mc_response.created_at.round.utc.to_s)
			
		end

		it 'should show the sa_response' do
	  		user = create(:student_with_saR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			sa_response = answer.responses.first
			number = sa_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(sa_response.name)
	   		expect(response['created_at'].to_s).to eql(sa_response.created_at.round.utc.to_s)
		end

		it 'should show the num_response' do
	  		user = create(:student_with_numR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			num_response = answer.responses.first
			number = num_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['num']).to eql(num_response.num)
	   		expect(response['created_at'].to_s).to eql(num_response.created_at.round.utc.to_s)
		end

		it 'should show the la_response' do
	  		user = create(:student_with_laR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			la_response = question.responses.first
			number = la_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

			expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(la_response.name)
	   		expect(response['created_at'].to_s).to eql(la_response.created_at.round.utc.to_s)
		end

	end

	#UPDATE
	#?? or always new ones??
	# Implementing for DEV testing/maintaing CRUD in case
	describe '/responses/#id' do

	    it 'should update the responses corresponding to #id' do
	    	user = create(:student_with_saR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			sa_response = answer.responses.first
			number = sa_response.id

		    put "/responses/#{number}", token: user.token, name: "hello world", course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id

		    body = JSON.parse(response.body)
		    s = body['data']['response']
		    expect(s['name']).to eql('hello world')

	    end

	end

	#DELETE
	#Can you dlete a responses?
	# Implementing for DEV testing/maintaing CRUD in case

  	describe '/responses/#id' do

	    it 'should delete the responses corresponding to #id' do
		    user = create(:student_with_mcR)
		    course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			mc_response = answer.responses.first
		    number = mc_response.id
		    delete "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, mc_answer_id: answer.id

		    expect(JSON.parse(response.body)).to include("status")
		    expect(JSON.parse(response.body)).to include("message")
		    expect(JSON.parse(response.body)).to include("data")
	    end

	end
	  
    #SHOW
	describe "correct reaponses" do

		it 'should show that num_response is correct' do
	  		user = create(:student_with_numR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			num_response = answer.responses.first
			number = num_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['num']).to eql(num_response.num)
			expect(response['correct']).to eql(num_response.correct)
	   		expect(response['created_at'].to_s).to eql(num_response.created_at.round.utc.to_s)
		end

		it 'should show that num_response is incorrect' do
	  		user = create(:student_with_numR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			num_response = answer.responses.first
			number = num_response.id
			#Make an incorrect response UPDATE
			put "/responses/#{number}", num: 43, token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id
			#Get Back updated response
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, num_answer_id: answer.id
			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['num']).to eql(43)
	   		expect(response['created_at'].to_s).to eql(num_response.created_at.round.utc.to_s)
		end

		it 'should show that sa_response is correct' do
	  		user = create(:student_with_saR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			sa_response = answer.responses.first
			number = sa_response.id
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id

			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['name']).to eql(sa_response.name)
			expect(response['correct']).to eql(sa_response.correct)
	   		expect(response['created_at'].to_s).to eql(sa_response.created_at.round.utc.to_s)
		end

		it 'should show that sa_response is incorrect' do
	  		user = create(:student_with_saR)
			course = user.courses.first
			session = course.sessions.first
			question = session.questions.first
			answer = question.answers.first
			sa_response = answer.responses.first
			number = sa_response.id
			#Make an incorrect response UPDATE
			put "/responses/#{number}", name: "wrong", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id
			#Get Back updated response
			get "/responses/#{number}", token: user.token, course_id: course.id, session_id: session.id, question_id: question.id, sa_answer_id: answer.id
			#If works
			body = JSON.parse(response.body)
			
			data = body['data']
	    	response = data['response']

	    	expect(response['token']).to eql(user.token)
			expect(response['name']).to eql("wrong")
	   		expect(response['created_at'].to_s).to eql(sa_response.created_at.round.utc.to_s)
		end



	end

end