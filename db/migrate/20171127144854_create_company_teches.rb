class CreateCompanyTeches < ActiveRecord::Migration[5.1]
  def change
    create_table :company_teches do |t|
      t.references :tech, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
