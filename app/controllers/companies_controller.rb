class CompaniesController < ApplicationController
  def index

    if params[:tool].nil?
      @companies = Company.joins(:company_tools).joins(:tools).where(:tools => { name: [params[:tool].split(",")] })
    else
      @companies = Company.all
    end
  end

  def show
    @company = Company.find(params[:id])
  end
end



# Company.first.company_tools.first.tool
