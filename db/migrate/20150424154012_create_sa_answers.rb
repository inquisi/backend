class CreateSaAnswers < ActiveRecord::Migration
  def change
    create_table :sa_answers do |t|
    	t.string :name
    	t.belongs_to :question
        t.timestamps null: false
    end
    create_table :sa_responses do |t|
    	t.string :name
    	t.belongs_to :sa_answer
    	t.belongs_to :user
        t.timestamps null: false
    end
  end
end
