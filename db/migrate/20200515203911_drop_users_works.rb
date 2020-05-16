class DropUsersWorks < ActiveRecord::Migration[6.0]
  def change
    drop_table :users_works
  end
end
