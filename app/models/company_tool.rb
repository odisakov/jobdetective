class CompanyTool < ApplicationRecord
  belongs_to :tool
  belongs_to :company
end
