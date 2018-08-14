class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :profile_picture
      t.string :location
      t.integer :age
      t.string :nationality
      t.string :languages
      t.string :introduction
      t.string :hobbies
      t.string :goals

      t.timestamps
    end
  end
end
