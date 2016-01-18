class DropInterestsUsers < ActiveRecord::Migration
  def change
    drop_table :interests_users
  end
end
