class Company < ApplicationRecord
  has_many :company_tools
  has_many :tools, through: :company_tools
  has_many :users, dependent: :destroy

  include AlgoliaSearch
   algoliasearch do
    # attribute :name
    attribute :com_tools do
      self.select {|c| c.tool.count > 0} do

      end
    end

end
