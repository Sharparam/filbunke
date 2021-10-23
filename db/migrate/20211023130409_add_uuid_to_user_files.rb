class AddUuidToUserFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :user_files, :uuid, :uuid, default: 'gen_random_uuid()'
    add_index :user_files, :uuid, unique: true
  end
end
