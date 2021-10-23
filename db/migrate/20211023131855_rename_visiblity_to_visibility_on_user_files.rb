class RenameVisiblityToVisibilityOnUserFiles < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_files, :visiblity, :visibility
  end
end
