class AddFavoriteGameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_game, :string
  end
end