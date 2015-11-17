class AddJoinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :join, :boolean
  end
end
