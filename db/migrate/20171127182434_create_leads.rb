class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :status
      t.text :notes
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
