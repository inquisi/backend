class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string 		:name
      t.string 		:category
      t.belongs_to	:session, 	index: true
      t.timestamps				null: false
    end
  end
end
