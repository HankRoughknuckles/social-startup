module ExternalAccountsHelper
  def hostsite_dropdown form
    form.select(:hostsite, 
                ExternalAccount.hostsite_options, 
                {}, 
                { class: "external_accounts_hostsite" })
  end
end
