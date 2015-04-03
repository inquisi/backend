# This is a file that defines mock data for testing
# through the use of 'factories' and the 'factory_girl' gem

FactoryGirl.define do
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

    factory :signup_user do
      password_confirmation "password"
    end
  end
end