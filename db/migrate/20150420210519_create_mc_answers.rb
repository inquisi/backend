class CreateMcAnswers < ActiveRecord::Migration
    def change
    	create_table :mc_answers do |t|
	    	t.text	 		:name
	    	t.belongs_to 	:question,	 	index: true
	    	t.boolean 		:correct
	    	t.integer 		:order
	        t.timestamps					null: false
    	end

	  	create_table :mc_responses do |t|
	    	t.belongs_to 	:mc_answer, 	index: true
	    	t.belongs_to 	:user, 			index: true
	    	t.timestamps 					null: false
    	end
	end
end
