class CompaniesController < ApplicationController
  def index

    @companies = Company.all if params[:tool].blank?
    if params[:tool]
      # @companies = Company.joins(:company_tools).joins(:tools).where(:tools => { name: [params[:tool].split(",")] }).distinct
      @companies = Company.joins(:company_tools).joins(:tools).where("tools.name ILIKE ?", "%#{ params[:tool] }%" ).distinct
    else
      @companies = Company.all
    end
  end

  def show
    @company = Company.find(params[:id])
  end


end
