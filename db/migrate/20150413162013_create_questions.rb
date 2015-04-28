class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
        t.boolean 	:active
        #FOR STI
        t.string    :type
        t.string    :category
      	t.string 		:name
      	t.integer		:order,		     index: true 
      	t.belongs_to	:session, 	 index: true
      	t.timestamps				       null: false
    end
  end
end
