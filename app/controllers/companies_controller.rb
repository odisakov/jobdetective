class CompaniesController < ApplicationController
  def index
    params[:search] ||= {}
    @companies = @companies.where(tool: params[:search][:tool]) if params[:search][:tool].present?
  end

  def show
    @company = Company.find(params[:id])
  end
end
