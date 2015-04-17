class AddUserIdToCourse < ActiveRecord::Migration
	def change
    	add_column :courses, :user_id, :integer
  		

	  	create_table :users_courses, id: false do |t|
    		t.belongs_to :user, index: true
        	t.belongs_to :course, index: true
    	end
	end
end
