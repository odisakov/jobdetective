class CreateUserTools < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tools do |t|
      t.references :user, foreign_key: true, index: true
      t.references :tool, foreign_key: true, index: true

      t.timestamps
    end
  end
end
