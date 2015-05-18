require 'rails_helper'
RSpec.describe "QuestionsSocketController" do
	before :each do
		@instructor = create :instructor_with_mcA
		@question = @instructor.courses.first.sessions.first.questions.first
		@answer = @question.answers.first
	end

	describe "respond" do
		before :each do
			@session_channel = "session_1"
			@question.update(active: true)
			@student = create(:student, email: 'student@gmail.com', first_name: "Student")
			@instructor.courses.first.students << @student
			@event = create_event('question.respond', {token: @student.token, question_id: @question.id, answer_id: @answer.id})
			allow_any_instance_of(WebsocketRails::BaseController).to receive(:connection_store).and_return({session_channel: @session_channel})
			WebsocketRails[@session_channel]
			@frozen_time = Time.local(1990)
			Timecop.freeze(@frozen_time)
		end

		after do
			Timecop.return
		end

		it "should create a new response to a question and return it if it doesn't exist already" do
			expect(Question.find(@question.id).responses.length).to eql 0
			expect(WebsocketRails.channel_manager.channels[@session_channel]).to receive(:trigger).with("question.respond".to_sym, {user_id: @student.id, answer_id: @answer.id, question_id: @question.id, created_at: @frozen_time})
			expect(@event.dispatch).to trigger_success_message
			expect(Question.find(@question.id).responses.length).to eql 1
		end

		it "should update a response to a question if one exists already for a user" do
			answer2 = @question.answers.create!(name: "test", order: 2, correct: false)
			answer2.responses.create!(user_id: @student.id)

			expect(@event.dispatch).to trigger_success_message
			expect(Question.find(@question.id).responses.length).to eql 1
			expect(Question.find(@question.id).responses.first.answer_id).to eql @answer.id 
		end

		it "should not allow responses to questions that are not active" do
			@question.update(active: false)
			expect(@event.dispatch).to trigger_failure_message({message: "Can't respond to a question that is not active"})
		end

		it "should trigger a failure if someone tries to respond to a course they aren't enrolled in" do
			@instructor.courses.first.update(students: [])
			expect(@event.dispatch).to trigger_failure_message({message: "Student with id #{@student.id} cannot respond to answer with id #{@answer.id} because they are not enrolled in that answer's course"})
		end
	end

	describe "activate" do
		it "should activate a given question" do
			allow_any_instance_of(WebsocketRails::BaseController).to receive(:connection_store).and_return({})
			event = create_event('question.activate', {token: @instructor.token, question_id: @question.id})

			expect(Question.first.active).to eql false
			event.dispatch
			expect(Question.first.active).to eql true
		end

		it "should set a sesion_id on connection_store" do
			event = create_event('question.activate', {token: @instructor.token, question_id: @question.id})
			connection_store = {}
			expect_any_instance_of(WebsocketRails::BaseController).to receive(:connection_store).and_return(connection_store)
			event.dispatch
			expect(connection_store[:session_id]).to eql @question.session.id
		end

		xit "should broadcast activation to the appropriate session channel" do
			event = create_event('question.activate', {token: @instructor.token, question_id: @question.id})
		end

		it "should render a failure if an instructor isn't found" do
			event = create_event('question.activate', {token: "BLAH", question_id: @question.id})
			expect(event.dispatch).to trigger_failure_message({message: "Invalid instructor token"})
		end

		it "should render a failure if a question isn't found" do
			event = create_event('question.activate', {token: @instructor.token, question_id: 0})
			expect(event.dispatch).to trigger_failure_message({message: "Question not found"})
		end
	end

	describe "deactivate" do
		it "should deactivate a given question" do
			event = create_event('question.deactivate', {token: @instructor.token, question_id: @question.id})
			@question.update(active: true)

			expect(Question.first.active).to eql true
			event.dispatch
			expect(Question.first.active).to eql false
		end

		it "should render a failure if an instructor isn't found" do
			event = create_event('question.deactivate', {token: "BLAH", question_id: @question.id})
			expect(event.dispatch).to trigger_failure_message({message: "Invalid instructor token"})
		end

		it "should render a failure if a question isn't found" do
			event = create_event('question.deactivate', {token: @instructor.token, question_id: 0})
			expect(event.dispatch).to trigger_failure_message({message: "Question not found"})
		end
	end

	# Can't figure out how to mock out connection_store values
	xit "should deactivate all questions from a previously activated session if an instructor's connection is disconnected" do
		allow_any_instance_of(WebsocketRails::BaseController).to receive(:connection_store).and_return({session_id: 'hellooo!'})
		Question.first.update(active: true)
		event = create_event('client_disconnected', nil)

		expect(Question.first.active).to eql true
		event.dispatch
		expect(Question.first.active).to eql false
	end

	xit "should only deactivate questions if an activate websocket request has been made previously" do

	end
end