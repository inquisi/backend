# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do 

  factory :num_answer do
    num           1
    question_id  "1"
  end

  factory :num_response do
    num             1
    num_answer_id  "1"

  end

  factory :sa_answer do
    name          "1"
    question_id   "1"
  end

  factory :sa_response do
    name          "1"
    user_id       "1"
    sa_answer_id  "1"
  end

  factory :la_response do
    name          "Rainbows are fun"
    question_id   "1"
    user_id       "1"

  end
  
  factory :mc_answer do
    name         "Test"
    correct      true
    question_id  "1"
    order        "1"
  end

  factory :mc_response do
    mc_answer_id    "1"
    user_id         "1"
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

    factory :student_with_courses_with_sessions do
      after :create do |student|
        student.courses = [create(:course, students: [student])]
        student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
      end

    end

    factory :student_with_courses_with_sessions_with_questions do
      after :create do |student|
        student.courses = [create(:course, students: [student])]
        student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
        student.courses.first.sessions.first.questions = [create(:question, session_id: "#{student.courses.first.sessions.first.id}")]
      end

    end

    factory :student_with_courses_with_sessions_with_questions_with_mc_answers do
      after :create do |student|
        student.courses = [create(:course, students: [student])]
        student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
        student.courses.first.sessions.first.questions = [create(:question, session_id: "#{student.courses.first.sessions.first.id}")]
        student.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
      end

    end

    factory :student_with_courses_with_sessions_with_questions_with_mc_answers_with_mc_responses do
      after :create do |student|
        student.courses = [create(:course, students: [student])]
        student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
        student.courses.first.sessions.first.questions = [create(:question, session_id: "#{student.courses.first.sessions.first.id}")]
        student.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
        student.courses.first.sessions.first.questions.first.mc_answers.first.mc_responses = [create(:mc_response, mc_answer_id: "#{student.courses.first.sessions.first.questions.first.mc_answers.first.id}")]
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

    factory :instructor_with_courses_with_sessions do
      after :create do |instructor|
        instructor.courses = [create(:course, instructors: [instructor])]
        instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
      end

    end

    factory :instructor_with_courses_with_sessions_with_questions do
      after :create do |instructor|
        instructor.courses = [create(:course, instructors: [instructor])]
        instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
        instructor.courses.first.sessions.first.questions = [create(:question, session_id: "#{instructor.courses.first.sessions.first.id}")]
      end

    end

    factory :instructor_with_courses_with_sessions_with_questions_with_mc_answers do
      after :create do |instructor|
        instructor.courses = [create(:course, instructors: [instructor])]
        instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
        instructor.courses.first.sessions.first.questions = [create(:question, session_id: "#{instructor.courses.first.sessions.first.id}")]
        instructor.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
      end

    end

    factory :instructor_with_courses_with_sessions_with_questions_with_mc_answers_with_mc_responses do
      after :create do |instructor|
        instructor.courses = [create(:course, instructors: [instructor])]
        instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
        instructor.courses.first.sessions.first.questions = [create(:question, session_id: "#{instructor.courses.first.sessions.first.id}")]
        instructor.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
        instructor.courses.first.sessions.first.questions.first.mc_answers.first.mc_responses = [create(:mc_response, mc_answer_id: "#{instructor.courses.first.sessions.first.questions.first.mc_answers.first.id}")]
      end

    end
  end
end