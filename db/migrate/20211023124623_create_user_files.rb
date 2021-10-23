class CreateUserFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_files do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :visiblity

      t.timestamps
    end
  end
end
