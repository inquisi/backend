require 'rails_helper'
RSpec.describe "QuestionsSocketController" do
	before :each do
		@user = create :instructor_with_courses_with_sessions_with_questions
		@question = @user.courses.first.sessions.first.questions.first
	end

	describe "activate" do
		it "should activate a given question" do
			event = create_event('questions.activate', {token: @user.token, question_id: @question.id})

			expect(Question.first.active).to eql false
			event.dispatch
			expect(Question.first.active).to eql true
		end

		it "should render a failure if an instructor isn't found" do
			event = create_event('questions.activate', {token: "BLAH", question_id: @question.id})
			expect(event.dispatch).to trigger_failure_message({message: "Invalid instructor token"})
		end

		it "should render a failure if a question isn't found" do
			event = create_event('questions.activate', {token: @user.token, question_id: 0})
			expect(event.dispatch).to trigger_failure_message({message: "Question not found"})
		end
	end

	describe "deactivate" do
		it "should deactivate a given question" do
			event = create_event('questions.deactivate', {token: @user.token, question_id: @question.id})
			Question.first.update(active: true)

			expect(Question.first.active).to eql true
			event.dispatch
			expect(Question.first.active).to eql false
		end

		it "should render a failure if an instructor isn't found" do
			event = create_event('questions.deactivate', {token: "BLAH", question_id: @question.id})
			expect(event.dispatch).to trigger_failure_message({message: "Invalid instructor token"})
		end

		it "should render a failure if a question isn't found" do
			event = create_event('questions.deactivate', {token: @user.token, question_id: 0})
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