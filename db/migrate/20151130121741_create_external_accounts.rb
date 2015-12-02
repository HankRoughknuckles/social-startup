class CreateExternalAccounts < ActiveRecord::Migration
  def change
    create_table :external_accounts do |t|
      t.string :site
      t.string :url
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :external_accounts, :users
  end
end
