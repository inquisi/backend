class AddEnrollmentTokenToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :enrollment_token, :int, unique: true, index: true
  end
end
