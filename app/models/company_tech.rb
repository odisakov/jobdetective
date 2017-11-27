class CompanyTech < ApplicationRecord
  belongs_to :tech
  belongs_to :company
end
