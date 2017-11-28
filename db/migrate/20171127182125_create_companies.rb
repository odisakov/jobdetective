class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :city
      t.string :country
      t.text :short_description

      t.timestamps
    end
  end
end
