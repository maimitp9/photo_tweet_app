class AlterUserNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :user_name, :string, null: false
    change_column :users, :password_digest, :string, null: false
  end
end
