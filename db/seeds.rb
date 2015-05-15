require 'factory_girl_rails'

cody = Student.create! first_name: "Cody", last_name: "Sehl", email: "cody@gmail.com", password: "password", password_confirmation: "password"
michael = Student.create! first_name: "Michael", last_name: "Gerten", email: "michael@gmail.com", password: "password", password_confirmation: "password"
nate = Student.create! first_name: "Nate", last_name: "Moore", email: "nate@gmail.com", password: "password", password_confirmation: "password"
matt = Student.create! first_name: "Matt", last_name: "Klich", email: "matt@gmail.com", password: "password", password_confirmation: "password"

jaime = Instructor.create! first_name: "Jaime", last_name: "Spacco", email: "jaime@gmail.com", password: "password", password_confirmation: "password"
john = Instructor.create! first_name: "John", last_name: "Dooley", email: "john@gmail.com", password: "password", password_confirmation: "password"

cs141 = Course.create! name: "CS 141", start: Time.now, finish: Time.now, students: [cody, michael], instructors: [jaime]
cs142 = Course.create! name: "CS 142", start: Time.now, finish: Time.now, students: [cody, michael], instructors: [john]
cs292 = Course.create! name: "CS 292", start: Time.now, finish: Time.now, students: [cody], instructors: [john]

session1 = cs141.sessions.create!(name: "Introduction", date: 0.days.from_now)
session2 = cs141.sessions.create!(name: "Variables", date: 1.days.from_now)
session3 = cs141.sessions.create!(name: "If Statements", date: 2.days.from_now)
session4 = cs141.sessions.create!(name: "For Loops", date: 3.days.from_now)

question1 = session2.questions.create!(name: "What is a variable?", category: "MC")
question2 = session2.questions.create!(name: "How to they work?", category: "MC")
question3 = session2.questions.create!(name: "Why does a duck go \"Quack!\"?", category: "MC")

answer1 = question1.answers.create!(name: "A piece of toast", correct: false, order: 0)
answer2 = question1.answers.create!(name: "A lovely frond", correct: true, order: 1)
answer3 = question2.answers.create!(name: "With intensive twiddling", correct: true, order: 0)
answer4 = question2.answers.create!(name: "They just do!", correct: false, order: 1)
answer5 = question2.answers.create!(name: "Magnets?", correct: false, order: 2)
answer6 = question3.answers.create!(name: "Why does anyone go \"Quack\", really?", correct: false, order: 0)
answer7 = question3.answers.create!(name: "How Can Ducks Go Quack If Our Eyes Can't Quack?", correct: true, order: 1)