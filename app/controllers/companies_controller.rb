class CompaniesController < ApplicationController
  def index
    # @companies = Company.all

    if params[:tool]
      @companies = Company.joins(:company_tools).joins(:tools).where(:tools => { name: [params[:tool].split(" ")] }).distinct
    else
      @companies = Company.all
    end
  end

  def show
    @company = Company.find(params[:id])
  end
end



# Company.first.company_tools.first.tool
