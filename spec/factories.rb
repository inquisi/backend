# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do  

  factory :mc_answer do
    name         "Test"
    correct      true
    question_id  "1"
    order        "1"
  end

  factory :mc_response do
    answer_id     "1"
    user_id       "1"
  end
 
  factory :question do
    name        "Test"
    category    "multi-choice"
    session_id  "1"
  end

  factory :organization do
    name        "Inquisi"
  end

  factory :session do
    name        "today"
    date        "05/03/2015"
    course_id   "1"
  end
  
  factory :course do
    name       "Test"
    start      "04/05/1993"
    finish     "05/06/2015"
    students    []
    instructors []
  end

  factory :user do
    first_name    "Cody"
    last_name     "Sehl"
    email         "cody.sehl@gmail.com"
    password      "password"

    factory :user_with_password_confirmation do
      password_confirmation "password"
    end

    factory :user_with_token do
      token "token"
    end
  end

  factory :student, class: Student, parent: :user do
    role    "Student"
    factory :student_with_courses do
        after :create do |student|
          student.courses = [create(:course, students: [student])]
        end
      end
  end

  factory :instructor, class: Instructor, parent: :user do
    role    "Instructor"
    factory :instructor_with_courses do
        # Create an array of 5 courses
        after :create do |instructor|
          instructor.courses = [create(:course, instructors: [instructor])]
        end
      end
  end
end