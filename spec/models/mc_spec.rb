require 'rails_helper'

RSpec.describe MC, type: :model do
  describe "respond" do
    before :each do
      @student = create :student_with_mcA
      @question = @student.courses.first.sessions.first.questions.first
      @answer = @question.answers.first
    end

    it "should create a new response given a student id and an answer id" do
      expect(Question.find(@question.id).responses.length).to eql 0
      expect(@question.respond(@student.id, @answer.id))
      expect(Question.find(@question.id).responses.length).to eql 1
    end

    it "should modify a student's response if one already exists" do
      answer2 = @question.answers.create(name: "test", order: 1, correct: false)
      @answer.responses.create!(user_id: @student.id)

      @question.respond(@student.id, answer2.id)

      student_responses = Question.find(@question.id).responses.where(user_id: @student.id)
      expect(student_responses.first.answer_id).to eql answer2.id
      expect(student_responses.length).to eql 1
    end

    it "should raise an exception if a student with student_id can't be found" do
      expect { @question.respond(-1, @answer.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should raise an exception if an answer with answer_id can't be found" do
      expect { @question.respond(@student.id, -1) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should raise an exception if someone tries to respond to a question in a course they are not enrolled in" do
      student2 = create(:student, email: "student2@gmail.com")
      expect { @question.respond(student2.id, @answer.id) }.to raise_error(NotEnrolledException)
    end
  end
end