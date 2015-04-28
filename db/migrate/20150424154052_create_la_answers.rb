class CreateLaAnswers < ActiveRecord::Migration
  def change
    create_table :la_responses do |t|
    	t.text :name
    	t.belongs_to :question,  index: true
    	t.belongs_to :user,      index: true
    	t.timestamps 			 null: false
    end
  end
end
