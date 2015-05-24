# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do 
  #Defaults
  factory :course do
    name       "Test"
    start      "04/05/1993"
    finish     "05/06/2015"
    students    []
    # sessions    []  #Is this needed??
    after :build do |course|
      if(course.instructors.length == 0)
        course.instructors = [create(:instructor, email: "courseInstructor@gmail.com", first_name: "Course", last_name: "Instructor")]
      end
    end
  end

  factory :session do
    name        "today"
    date        "05/03/2015"
    course_id   "1"
    active      false
    allow_anonymous false
  end

  factory :question do
    name        "Test"
    order       1
    session_id  "1"
    active      false
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
  #End of Questions

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
    name         "Correct"
    sa_answer_id "1"
    #defaults to wrong-> check for correctness when saved
    correct       false

  end

  factory :numR, class: NumResponse, parent: :response do
    num_answer_id "1"
    num           1
    #defaults to wrong-> check for correctness when saved
    correct       false

  end

  factory :laR, class: LaResponse, parent: :response do
    name          "Test"
    user_id       "1"
  end
  #End of Responses

  factory :organization do
    name        "Inquisi"
  end

  factory :user, class: RegisteredUser do
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

  factory :anonymous_student, class: AnonymousStudent do
    role "AnonymousStudent"
    name "Anonymous Jeff"
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
#####################################################################################################
#STUDENTS CANT HAVE QUESTIONS OR ANSWERS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!###########################
    # #Question with no answers or responses
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

    # #Question with Answers
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
###############################DONT DELETE ^^^^^ IN CASE NEED LATER ##################################

    #Question with Responses
    factory :student_with_mcR do
      after :create do |student|
        courses = [create(:course, students: [student])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        answers = [create(:mcA, question_id: "#{questions.first.id}")]
        responses = [create(:mcR, mc_answer_id: "#{answers.first.id}", user_id: "#{student.id}")]
        
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
        responses = [create(:saR, sa_answer_id: "#{answers.first.id}", user_id: "#{student.id}")]
        
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
        responses = [create(:numR, num_answer_id: "#{answers.first.id}", user_id: "#{student.id}")]
        
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
        responses = [create(:laR, question_id: "#{questions.first.id}", user_id: "#{student.id}")]
 
        questions.first.responses = responses
        sessions.first.questions = questions
        courses.first.sessions = sessions
        student.courses = courses
      end

    end
    #End of Student Factories
  end

#################################################################################
#######################  SO OBVOUIS BREAK IN CODE   #############################
#################################################################################

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

    #Question default is Multi-choice
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
    
        #Question with no answers or responses
    factory :instructor_with_mc do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    factory :instructor_with_sa do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:sa, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end    

    factory :instructor_with_num do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:num, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    factory :instructor_with_la do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:la, session_id: "#{sessions.first.id}")]
        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    #Question with Answers
    factory :instructor_with_mcA do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        answers = [create(:mcA, question_id: "#{questions.first.id}")]
 
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    factory :instructor_with_saA do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:sa, session_id: "#{sessions.first.id}")]
        answers = [create(:saA, question_id: "#{questions.first.id}")]
 
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    factory :instructor_with_numA do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:num, session_id: "#{sessions.first.id}")]
        answers = [create(:numA, question_id: "#{questions.first.id}")]
 
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end
############################################################################################################
############################################################################################################
    #Question with Responses (INSTRUCTORS DON'T HAVE RESPONSES)
    factory :instructor_with_mcR do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:mc, session_id: "#{sessions.first.id}")]
        answers = [create(:mcA, question_id: "#{questions.first.id}")]
        responses = [create(:mcR, mc_answer_id: "#{answers.first.id}")]
        
        answers.first.responses = responses
        questions.first.answers = answers        
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    factory :instructor_with_saR do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:sa, session_id: "#{sessions.first.id}")]
        answers = [create(:saA, question_id: "#{questions.first.id}")]
        responses = [create(:saR, sa_answer_id: "#{answers.first.id}")]
        
        answers.first.responses = responses
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    factory :instructor_with_numR do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:num, session_id: "#{sessions.first.id}")]
        answers = [create(:numA, question_id: "#{questions.first.id}")]
        responses = [create(:numR, num_answer_id: "#{answers.first.id}")]
        
        answers.first.responses = responses
        questions.first.answers = answers
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end

    # #Special Case, no answer for LaR
    factory :instructor_with_laR do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor])]
        sessions = [create(:session, course_id: "#{courses.first.id}")]
        questions = [create(:la, session_id: "#{sessions.first.id}")]
        responses = [create(:laR, question_id: "#{questions.first.id}")]
 
        questions.first.responses = responses
        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses
      end

    end
###############################DONT DELETE ^^^^^ IN CASE NEED LATER ##################################

    #End Of Instructor Factories
  end

#CUSTOM FACTORIES::::
#BUILDING custom/ unique test stituation, trying to stress/break backend
#&& verify complicated behavoir
factory :custom, class: Instructor, parent: :user do
    role    "Instructor"

    factory :student_with_response_to_question do
      after :create do |instructor|
        courses = [create(:course, instructors: [instructor], name: "Fall 2016")]
        sessions = [create(:session, course_id: "#{courses.first.id}", name: "Friday")]
        questions = [create(:mc, session_id: "#{sessions.first.id}", name: "Rainbow")]
        
        #Make five different answers
        $num = 0
        $max = 5
        while $num < $max do

          answer = [create(:mcA, question_id: "#{questions.first.id}", name: "Rainbow + $num")]
          questions.first.answers[$num] = answer

          $num = $num + 1

        end

        sessions.first.questions = questions
        courses.first.sessions = sessions
        instructor.courses = courses

        #Make a student and respond to answer 3

        student  = [create(:student)]
        courses.first.students = student
        response = [create(:mcR, user_id: student.id, mc_answer_id: instructor.questions.first.answers[2].id)]
        student.responses.first = response

        #Hopefully this works,
        #Cody don't yell at me ;)

      end

    end
 
  end






# End of Document 
end