class CreateSaAnswers < ActiveRecord::Migration
  def change
    create_table :sa_answers do |t|
    	t.text         :name
    	t.belongs_to   :question,      index: true
        t.timestamps                   null: false
    end
    create_table :sa_responses do |t|
    	t.string       :name
        t.boolean      :correct
    	t.belongs_to   :sa_answer,     index: true
    	t.belongs_to   :user,          index: true
        t.timestamps                   null: false
    end
  end
end
