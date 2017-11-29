class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :employment_role, :string
  end
end
