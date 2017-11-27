class CreateUserTeches < ActiveRecord::Migration[5.1]
  def change
    create_table :user_teches do |t|
      t.references :user, foreign_key: true
      t.references :tech, foreign_key: true

      t.timestamps
    end
  end
end
