class AddDefaultValueToVisibilityOnUserFiles < ActiveRecord::Migration[6.1]
  def change
    change_column :user_files, :visibility, :integer, default: 0
  end
end
