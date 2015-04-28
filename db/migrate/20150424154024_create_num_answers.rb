class CreateNumAnswers < ActiveRecord::Migration
  def change
    create_table :num_answers do |t|
    	t.integer      :num
    	t.belongs_to   :question,      index: true
        t.timestamps                   null: false
    	
    end
    create_table :num_responses do |t|
    	t.integer      :num
    	t.belongs_to   :num_answer,    index: true
    	t.belongs_to   :user,          index: true
        t.timestamps                   null: false
    end
  end
end
