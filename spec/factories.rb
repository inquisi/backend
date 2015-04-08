# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do  factory :session do
    
  end
  factory :course do
    
  end

  # Examples!


  # factory :user do
  #   first_name "John"
  #   last_name  "Doe"
  #   admin false
  # end
  #
  # # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end

  factory :user do
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
  end
end