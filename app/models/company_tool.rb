class CompanyTool < ApplicationRecord
  belongs_to :tool
  belongs_to :company


  include AlgoliaSearch
  algoliasearch do
    # attribute :name
  end
end
