# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do  
  factory :organization do
    name "Inquisi"
  end
  factory :session do
    
  end
  factory :course do
    title "test"
  end


  

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

    #Student Mode
    factory :user_with_role_student do
      role "student"
    end
    factory :user_with_booleans_student do
      student      true
      instructor   false
    end

    #Instructor Mode
    factory :user_with_role_instructor do
      role "instructor"
    end
    factory :user_with_booleans_instructor do
      student      false
      instructor   true
    end

  end

end