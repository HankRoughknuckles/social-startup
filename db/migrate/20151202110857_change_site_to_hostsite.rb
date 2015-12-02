class ChangeSiteToHostsite < ActiveRecord::Migration
  def change
    rename_column :external_accounts, :site, :hostsite
  end
end
