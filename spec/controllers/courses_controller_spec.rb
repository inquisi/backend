require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

  render_views

  describe "create" do
    it "should take a name, start date, finish date and a token and create a course record and associate it with a user" do
      # attributes_for returns a hash of values as they're defined in factories.rb
      instructor = create(:instructor)
      
      expect {
        post :create , attributes_for(:course).merge(token: instructor.token)
      }.to change(Course, :count).by(1)

      expect(instructor.courses.size).to be(1)
    end
  end
end