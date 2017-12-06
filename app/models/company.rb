class Company < ApplicationRecord
  has_many :company_tools
  has_many :tools, through: :company_tools
  has_many :users, dependent: :destroy

  include AlgoliaSearch
   algoliasearch do

    attribute :id, :name, :short_description, :logo_url

    add_attribute :tool_name

    searchableAttributes ['tool_name']
  end

  def tool_name
    tools = []
    self.tools.each do |t|
      puts t.name
      tools << t.name
    end
    tools
  end

end
