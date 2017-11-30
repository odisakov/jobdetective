class AddHomepageDomainToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :homepage_domain, :string
  end
end
