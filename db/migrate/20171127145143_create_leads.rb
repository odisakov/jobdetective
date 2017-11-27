class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.references :user, foreign_key: true
      t.integer :contact_id
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
