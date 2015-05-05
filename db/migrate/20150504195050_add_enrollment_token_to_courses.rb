class AddEnrollmentTokenToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :enrollment_token, :int, index: true
  end
end
