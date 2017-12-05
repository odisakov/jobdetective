class UserTool < ApplicationRecord
  belongs_to :user
  belongs_to :tool


  include AlgoliaSearch
  algoliasearch do
    # attribute :name
  end
end
