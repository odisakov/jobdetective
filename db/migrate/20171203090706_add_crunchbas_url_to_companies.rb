class AddCrunchbasUrlToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :crunchbase_url, :string
  end
end
