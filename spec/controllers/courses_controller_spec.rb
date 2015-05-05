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

  describe "enroll" do
  	before(:each) do
  		@instructor1 = create(:instructor_with_courses, email: "jaime@gmail.com", first_name: "Jaime")
  		@instructor2 = create(:instructor_with_courses, email: "jaime2@gmail.com", first_name: "Jaime2")
  		@student = create :student
  	end

    it "should enroll a student in a course" do
    	expect(Instructor.first.courses.first.students.length).to eql(0) 

		post :enroll, {token: @student.token, enrollment_token: @instructor1.courses.first.enrollment_token}

    	expect(Instructor.first.courses.first.students.length).to eql(1) 
    end

    it "should not enroll an instructor" do
    	post :enroll, {token: @instructor2.token, enrollment_token: @instructor1.courses.first.enrollment_token}

    	expect(Instructor.first.courses.first.students.length).to eql(0) 
    end

    it "shouldnt change anything if a student enrolls twice in the same class" do
    	expect(Instructor.first.courses.first.students.length).to eql(0) 

		post :enroll, {token: @student.token, enrollment_token: @instructor1.courses.first.enrollment_token}
		post :enroll, {token: @student.token, enrollment_token: @instructor1.courses.first.enrollment_token}
    	
    	expect(Instructor.first.courses.first.students.length).to eql(1) 
    end
  end
end