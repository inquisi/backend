class CreateCoursesAndUsers < ActiveRecord::Migration
  def change
  	# Join tables use lexical order by default
  	# Table name should be courses_users, not users_courses
  	# HASHTAGthemoreyouknow
    create_table :courses_users, id: false do |t|
      t.belongs_to :user, 		index: true
      t.belongs_to :course, 	index: true
    end
  end
end
