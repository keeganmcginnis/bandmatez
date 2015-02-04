class AddSystemTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :system_type, :string
  end
end