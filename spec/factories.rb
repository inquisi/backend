# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do  


  factory :question do
    name "1"
    category "multi-choice"
    session_id "1"
  end

  factory :organization do
    name "Inquisi"
  end

  factory :session do
    name "today"
    date "05/03/2015"
    course_id "1"
  end
  
  factory :course do
    name "test"
    start "04/05/1993"
    finish "05/06/2015"
    user_id "1"

    factory :course_with_token do
      token "token"
    end
  end

  # factory :question do
  #   name         "test"
  #   questionText ""
  # end
  # factory :answer  do
  #   name         "test"
  #   answerText   ""
  #   question     ""
  # end

  factory :user do
    #General properties of all users
    first_name "Cody"
    last_name "Sehl"
    email "cody.sehl@gmail.com"
    password "password"

    factory :user_with_password_confirmation do
      password_confirmation "password"
    end

    factory :user_with_token do
      token "token"
    end

    factory :student do
      role "Student"
    end

    factory :instructor do
      role "Instructor"
    end
  end
end