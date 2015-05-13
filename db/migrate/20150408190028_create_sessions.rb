class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
        t.boolean 	:active, default: false
      	t.text	 		:name
      	t.date 			:date
      	t.belongs_to 	:course,	index: true
      	t.timestamps 				null: false
    end
  end
end
