require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

  describe "create" do

    it "should make a course record and associate it with an user" do
      
      instructor = create(:instructor)
      
      expect {
        post :create , attributes_for(:course).merge(token: instructor.token)
      }.to change(Course, :count).by(1)

      expect(instructor.courses.size).to be(1)
    end

  end

end