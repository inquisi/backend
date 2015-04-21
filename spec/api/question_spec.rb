require 'rails_helper'

RSpec.describe 'Question API', type: :request do
  # render_views


  describe "/create" do
      it "should return a question confirm json if creation successful" do
        post '/questions', attributes_for(:question)

        expect(JSON.parse(response.body)).to include("status")
        expect(JSON.parse(response.body)).to include("message")
        expect(JSON.parse(response.body)).to include("data")
        expect(JSON.parse(response.body)["data"]).to include("question")
        expect(JSON.parse(response.body)["data"]["question"]).to include("name")
        expect(JSON.parse(response.body)["data"]["question"]).to include("date")

      end

      it "should return an error if question creation unsuccessful" do
        question_hash = attributes_for(:question)
        question_hash[:name] = ""
        post '/questions', question_hash
        expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      end
    
  end
  describe "/questions" do
      # it "should return a list of questions json if creation successful" do
      #   get '/questions', attributes_for(:question)

      #   expect(JSON.parse(response.body)).to include("status")
      #   expect(JSON.parse(response.body)).to include("message")
      #   expect(JSON.parse(response.body)).to include("data")
      #   expect(JSON.parse(response.body)["data"]).to include("question")
      #   expect(JSON.parse(response.body)["data"]["question"]).to include("name")
      #   expect(JSON.parse(response.body)["data"]["question"]).to include("date")

      # end

      # it "should return an error if question creation unsuccessful" do
      #   question_hash = attributes_for(:question)
      #   question_hash[:name] = ""
      #   post '/questions', question_hash
      #   expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      # end
    
  end
  describe "/questions/#id" do
      # it "should return a question confirm json if creation successful" do
      #   post '/questions', attributes_for(:question)

      #   expect(JSON.parse(response.body)).to include("status")
      #   expect(JSON.parse(response.body)).to include("message")
      #   expect(JSON.parse(response.body)).to include("data")
      #   expect(JSON.parse(response.body)["data"]).to include("question")
      #   expect(JSON.parse(response.body)["data"]["question"]).to include("name")
      #   expect(JSON.parse(response.body)["data"]["question"]).to include("date")

      # end

      # it "should return an error if question creation unsuccessful" do
      #   question_hash = attributes_for(:question)
      #   question_hash[:name] = ""
      #   post '/questions', question_hash
      #   expect(response.body).to eql({status: 'failure', message: 'Failed to create a question', data: {}}.to_json)
      # end
    
  end
end