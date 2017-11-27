class CreateCompanyTools < ActiveRecord::Migration[5.1]
  def change
    create_table :company_tools do |t|
      t.references :tool, foreign_key: true, index: true
      t.references :company, foreign_key: true, index: true

      t.timestamps
    end
  end
end
