require 'rails_helper'

RSpec.describe Course, type: :model do
  
  describe "/create" do
    it "should create a course" do
      post '/createcourse', attributes_for(:user_with_authorization).merge(attributes_for(:course))

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("user")
      expect(JSON.parse(response.body)["data"]["user"]).to include("token")

      expect(JSON.parse(response.body)["data"]["user"]).not_to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).not_to include("first_name")
    end

    it "should return an error if course creation unsuccessful" do
      course_hash = attributes_for(:user_with_authorization).merge(attributes_for(:course))
      course_hash[:title] = ""
      post '/createcourse', course_hash

      expect(response.body).to eql({status: 'failure', message: 'Course is invalid', data: ""}.to_json)
    end
  end
  describe "/get" do
    it "should get a course" do
      post '/getcourse', attributes_for(:user_with_authorization).merge(attributes_for(:course))

      expect(JSON.parse(response.body)).to include("status")
      expect(JSON.parse(response.body)).to include("message")
      expect(JSON.parse(response.body)).to include("data")
      expect(JSON.parse(response.body)["data"]).to include("course")
      expect(JSON.parse(response.body)["data"]["user"]).to include("name")
	  expect(JSON.parse(response.body)["data"]["user"]).to include("time")

      expect(JSON.parse(response.body)["data"]["user"]).not_to include("email")
      expect(JSON.parse(response.body)["data"]["user"]).not_to include("first_name")
    end

    it "should return an error if course get unsuccessful" do
      course_hash = attributes_for(:user_with_authorization).merge(attributes_for(:course))
      course_hash[:title] = ""
      post '/getcourse', course_hash

      expect(response.body).to eql({status: 'failure', message: 'Course is invalid', data: ""}.to_json)
    end
  end



end
