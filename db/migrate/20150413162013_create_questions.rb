class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
        t.boolean 	:active
        #FOR STI
        t.string    :category

      	t.text  		:name
      	t.integer		:order,		     index: true 
      	t.belongs_to	:session, 	 index: true
      	t.timestamps				       null: false
    end
  end
end
