class ChangeDataTypePublicationYear < ActiveRecord::Migration[6.0]
  def change
    change_column :works, :publication_year, :string
  end
end
