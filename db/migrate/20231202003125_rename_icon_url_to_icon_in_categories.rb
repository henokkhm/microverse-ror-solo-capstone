class RenameIconUrlToIconInCategories < ActiveRecord::Migration[7.1]
  def change
    rename_column :categories, :icon_url, :icon
  end
end
