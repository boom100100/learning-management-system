class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :password_digest
    end

    add_index :admins, :username, unique: true
  end

end
