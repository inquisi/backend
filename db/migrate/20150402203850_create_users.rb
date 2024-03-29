class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.string  :password_digest
      t.string  :token
      t.index   :token  
      #For STI 
      t.string  :role
      
      t.boolean :trial
      t.timestamps            null: false
    end
    add_index :users, :email, unique: true
  end
end
