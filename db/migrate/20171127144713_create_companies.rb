class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :crunchbase_uuid
      t.string :crunchbase_url
      t.string :homepage_domain
      t.string :profile_image_url
      t.string :linkedin_url
      t.text :short_description

      t.timestamps
    end
  end
end
