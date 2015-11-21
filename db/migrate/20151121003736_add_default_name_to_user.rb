class AddDefaultNameToUser < ActiveRecord::Migration
  def change
    change_column :users, :first_name, :string, :default => "User"
  end
end
