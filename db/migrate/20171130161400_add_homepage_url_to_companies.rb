class AddHomepageUrlToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :homepage_url, :string
  end
end
