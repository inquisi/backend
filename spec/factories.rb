# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do 
  #Defaults
  factory :course do
    name       "Test"
    start      "04/05/1993"
    finish     "05/06/2015"
    students    []
    instructors []
    # sessions    []  #Is this needed??
  end

  factory :session do
    name        "today"
    date        "05/03/2015"
    course_id   "1"
    active      true
    # questions    [] #Is this needed??
  end

  #Start of Questions
  factory :question do
    name        "Test"
    session_id  "1"
    active      true
    # answers     []  #Is this needed??
  end

  factory :mc, class: MC, parent: :question do
    category        "MC"
  end

  factory :sa, class: SA, parent: :question do
    category        "SA"
  end

  factory :la, class: LA, parent: :question do
    category        "LA"
  end

  factory :num, class: NUM, parent: :question do
    category        "NUM"
  end
  #Start of Questions

  #Start of Answers
  factory :answer do
    question_id    "1"
  end

  factory :mcA, class: McAnswer, parent: :answer do
    name         "test"
    correct      true
    order        "2"
  end

  factory :saA, class: SaAnswer, parent: :answer do
    name         "test"
  end

  factory :numA, class: NumAnswer, parent: :answer do
    num          1
  end

  #Does not exist
  # factory :laA, class: LaAnswer, parent: :answer do
  # end

  #End of Answers

  #Start of Responses
  factory :response do
    user_id        "1"

  end

  factory :mcR, class: McResponse, parent: :response do
    mc_answer_id    "1"
  end

  factory :saR, class: SaResponse, parent: :response do
    name         "Test"
    sa_answer_id "1"
  end

  factory :numR, class: NumResponse, parent: :response do
    num_answer_id "1"
    num           1
  end

  factory :laR, class: LaResponse, parent: :response do
    name          "Test"
    user_id       "1"
  end
  #End of Responses

  factory :organization do
    name        "Inquisi"
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

    #Start of Student Factories
  factory :student, class: Student, parent: :user do
    role    "Student"

    factory :student_with_courses do
      after :create do |student|
        courses = [create(:course, students: [student])]
        
        student.courses = courses
      end

    end

    factory :student_with_courses_with_sessions do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]

        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    #Question default is Multi-choice
    factory :student_with_courses_with_sessions_with_questions do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    #Question with no answers or responses
    factory :student_with_mc do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    factory :student_with_sa do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:sa, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end    

    factory :student_with_num do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:num, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    factory :student_with_la do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:la, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    #Question with Answers
    factory :student_with_mcA do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        answers = [create(:mcA, question_id: "#{questions.first.id}")]
 
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    factory :student_with_saA do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:sa, session_id: "#{sessions.first.id}")]
        answers = [create(:saA, question_id: "#{questions.first.id}")]
 
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    factory :student_with_numA do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:num, session_id: "#{sessions.first.id}")]
        answers = [create(:numA, question_id: "#{questions.first.id}")]
 
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    #Question with Responses
    factory :student_with_mcR do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        answers = [create(:mcA, question_id: "#{questions.first.id}")]
        responses = [create(:mcR, mc_answer_id: "#{answers.first.id}")]
        
        answers.first.responses = responses
        questions.first.answers = answers        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    factory :student_with_saR do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:sa, session_id: "#{sessions.first.id}")]
        answers = [create(:saA, question_id: "#{questions.first.id}")]
        responses = [create(:saR, sa_answer_id: "#{answers.first.id}")]
        
        answers.first.responses = responses
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    factory :student_with_numR do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:num, session_id: "#{sessions.first.id}")]
        answers = [create(:numA, question_id: "#{questions.first.id}")]
        responses = [create(:numR, num_answer_id: "#{answers.first.id}")]
        
        answers.first.responses = responses
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end

    #Special Case, no answer for LaR
    factory :student_with_laR do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:la, session_id: "#{sessions.first.id}")]
        responses = [create(:laR, question_id: "#{questions.first.id}")]
 
        questions.first.responses = responses
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end
    #End of Student Factories
  end

    #Start of Instructors Factories
  factory :instructor, class: Instructor, parent: :user do
    role    "Instructor"

    factory :instructor_with_courses do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        
        instructor.courses = courses
      end

    end

    factory :instructor_with_courses_with_sessions do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    factory :instructor_with_courses_with_sessions_with_questions do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end
    #End Of Instructor Factories
  end
# End of Document ::::: OLD CODE BELOW ::::::  BEWARE

  # factory :student, class: Student, parent: :user do
  #   role    "Student"

  #   factory :student_with_courses do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #     end
  #   end

  #   factory :student_with_courses_with_sessions do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #     end

  #   end

  #   factory :student_with_courses_with_sessions_with_questions do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:mc, session_id: "#{student.courses.first.sessions.first.id}")]
  #     end

  #   end

  #   factory :student_with_mc_answers do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:mc, session_id: "#{student.courses.first.sessions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
  #     end

  #   end
  #   factory :student_with_sa_answers do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:sa, session_id: "#{student.courses.first.sessions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.sa_answers = [create(:sa_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
  #     end

  #   end
  #   factory :student_with_num_answers do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:num, session_id: "#{student.courses.first.sessions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.num_answers = [create(:num_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
  #     end

  #   end
  #   factory :student_with_la_responses do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:la, session_id: "#{student.courses.first.sessions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.la_responses = [create(:la_response, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
  #     end

  #   end

  #   factory :student_with_mc_answers_with_mc_responses do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:mc, session_id: "#{student.courses.first.sessions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.mc_answers.first.mc_responses = [create(:mc_response, mc_answer_id: "#{student.courses.first.sessions.first.questions.first.mc_answers.first.id}")]
  #     end

  #   end
  #   factory :student_with_sa_answers_with_sa_responses do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:sa, session_id: "#{student.courses.first.sessions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.sa_answers = [create(:sa_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.sa_answers.first.sa_responses = [create(:sa_response, sa_answer_id: "#{student.courses.first.sessions.first.questions.first.sa_answers.first.id}")]
  #     end

  #   end
  #   factory :student_with_num_answers_with_num_responses do
  #     after :create do |student|
  #       student.courses = [create(:course, students: [student])]
  #       student.courses.first.sessions = [create(:session, course_id: "#{student.courses.first.id}")]
  #       student.courses.first.sessions.first.questions = [create(:num, session_id: "#{student.courses.first.sessions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.num_answers = [create(:num_answer, question_id: "#{student.courses.first.sessions.first.questions.first.id}")]
  #       student.courses.first.sessions.first.questions.first.num_answers.first.num_responses = [create(:num_response, num_answer_id: "#{student.courses.first.sessions.first.questions.first.num_answers.first.id}")]
  #     end

  #   end

  # end

  # factory :instructor, class: Instructor, parent: :user do
  #   role    "Instructor"
  #   factory :instructor_with_courses do
  #     # Create an array of 5 courses
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #     end
  #   end

  #   factory :instructor_with_courses_with_sessions do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #     end

  #   end

  #   factory :instructor_with_questions do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #       instructor.courses.first.sessions.first.questions = [create(:mc, session_id: "#{instructor.courses.first.sessions.first.id}")]
  #     end

  #   end

  #   factory :instructor_with_mc_answers do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #       instructor.courses.first.sessions.first.questions = [create(:mc, session_id: "#{instructor.courses.first.sessions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
  #     end

  #   end

  #   factory :instructor_with_sa_answers do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #       instructor.courses.first.sessions.first.questions = [create(:sa, session_id: "#{instructor.courses.first.sessions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.sa_answers = [create(:sa_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
  #     end

  #   end

  #   factory :instructor_with_num_answers do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #       instructor.courses.first.sessions.first.questions = [create(:num, session_id: "#{instructor.courses.first.sessions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.num_answers = [create(:num_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
  #     end

  #   end

  #   factory :instructor_with_mc_answers_with_mc_responses do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #       instructor.courses.first.sessions.first.questions = [create(:mc, session_id: "#{instructor.courses.first.sessions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.mc_answers = [create(:mc_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.mc_answers.first.mc_responses = [create(:mc_response, mc_answer_id: "#{instructor.courses.first.sessions.first.questions.first.mc_answers.first.id}")]
  #     end

  #   end
  #   factory :instructor_with_sa_answers_with_sa_responses do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #       instructor.courses.first.sessions.first.questions = [create(:sa, session_id: "#{instructor.courses.first.sessions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.sa_answers = [create(:sa_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.sa_answers.first.sa_responses = [create(:sa_response, sa_answer_id: "#{instructor.courses.first.sessions.first.questions.first.sa_answers.first.id}")]
  #     end

  #   end
  #   factory :instructor_with_num_answers_with_num_responses do
  #     after :create do |instructor|
  #       instructor.courses = [create(:course, instructors: [instructor])]
  #       instructor.courses.first.sessions = [create(:session, course_id: "#{instructor.courses.first.id}")]
  #       instructor.courses.first.sessions.first.questions = [create(:num, session_id: "#{instructor.courses.first.sessions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.num_answers = [create(:num_answer, question_id: "#{instructor.courses.first.sessions.first.questions.first.id}")]
  #       instructor.courses.first.sessions.first.questions.first.num_answers.first.num_responses = [create(:num_response, num_answer_id: "#{instructor.courses.first.sessions.first.questions.first.num_answers.first.id}")]
  #     end

  #   end
  # end
end