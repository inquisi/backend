class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|rake 
    	t.string :name
    	t.date :date
        t.timestamps null: false
        add_column :sessions, :course_id, :integer
    end
  end
end
