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

    factory :student do
      role "Student"
    end

    factory :instructor do
      role "Instructor"
    end
  end
end