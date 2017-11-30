class Lead < ApplicationRecord
  belongs_to :user
  belongs_to :person, class_name: "User"
end


