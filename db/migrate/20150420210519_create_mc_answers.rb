class CreateMcAnswers < ActiveRecord::Migration
    def change
    	create_table :mc_answers do |t|
	    	t.string 		:name
	    	t.belongs_to 	:question, index: true
	    	t.boolean 		:correct
	    	t.integer 		:order
	        t.timestamps null: false
    	end

	  	create_table :mc_responses do |t|
	    	t.belongs_to 	:answer
	    	t.belongs_to 	:user
	    	t.timestamps null: false
    	end
	end
end
