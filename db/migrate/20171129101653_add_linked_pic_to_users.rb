class AddLinkedPicToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :linkedin_pic_url, :string
  end
end
