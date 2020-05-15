class ChangeTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :users_works_joins, :users_works
  end
end
