class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :email
  		t.string :password_digest #BCrypt will store a salted, hashed version of the users' passwords in our database in a column called password_digest
  	end
  end
end
