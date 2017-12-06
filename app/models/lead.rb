class Lead < ApplicationRecord
  belongs_to :user
  belongs_to :person, class_name: "User"

  include AlgoliaSearch
  algoliasearch do
    # attribute :name
  end
end


