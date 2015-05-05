class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text 		:name
      t.date 		:start
      t.date 		:finish
      t.timestamps 				null: false
    end
  end
end
