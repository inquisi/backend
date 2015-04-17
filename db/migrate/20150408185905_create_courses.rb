class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :start_date
      t.string :end_date
      t.timestamps null: false
    end
  end
end
