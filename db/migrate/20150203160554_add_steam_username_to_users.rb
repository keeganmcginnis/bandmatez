class AddSteamUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :steam_username, :string
  end
end
