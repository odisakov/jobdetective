class UserTech < ApplicationRecord
  belongs_to :user
  belongs_to :tech
end
