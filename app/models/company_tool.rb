class CompanyTool < ApplicationRecord
  belongs_to :tool
  belongs_to :company

  def tool_name
    self.tool.name
  end

end
