class AddPersistanceTokenToUser < ActiveRecord::Migration
  def change
    add_column :user, :persistence_token, :string
  end
end
