class AddProviderUidUniqueIndexToAuthentications < ActiveRecord::Migration[6.1]
  def change
    add_index :authentications, [:provider, :uid], unique: true
  end
end
