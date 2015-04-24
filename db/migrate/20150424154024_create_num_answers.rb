class CreateNumAnswers < ActiveRecord::Migration
  def change
    create_table :num_answers do |t|
    	t.integer :num
    	t.belongs_to :question
        t.timestamps null: false
    	
    end
    create_table :num_responses do |t|
    	t.integer :num
    	t.belongs_to :num_answer
    	t.belongs_to :user
        t.timestamps null: false
    end
  end
end
