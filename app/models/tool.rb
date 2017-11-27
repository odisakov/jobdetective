class Tool < ApplicationRecord
  has_many :company_tools
  has_many :user_tools
  has_many :companies, through: :company_tools
end
