class CompaniesController < ApplicationController
  def index
    # @companies = Company.all

    @companies = Company.joins(:company_tools).joins(:tools).where(:tools => { name: [params[:tool].split(",")] })
    # @companies = @companies.where(:tools => { name: 'ruby' } ).all

    # if params[:search]
    #   @companies = Company.includes(:company_tools)
    #   raise
    #   @companies = @companies.where(tool: params[:search][:tool]) if params[:search][:tool]

    # else
    #   @companies = Company.all
    # end
    # @companies = @companies.where(tool: params[:search][:tool]) if params[:search][:tool]
  end

  def show
    @company = Company.find(params[:id])
  end
end



# Company.first.company_tools.first.tool
