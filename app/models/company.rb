class Company < ApplicationRecord
  has_many :company_tools
  has_many :tools, through: :company_tools
  has_many :users
end
