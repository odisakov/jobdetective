class LeadsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @person = User.find(params[:user_id])
    # CHECK IF LEAD ALREADY EXIST
    @lead = Lead.new(user: current_user, person: @person)
    if @lead.save
      respond_to do |format|
        format.js {  flash[:notice] = "Lead added" }
        end


      # flash[:notice] = "Lead added"
    else
      flash[:alert] = "We couldn't add the Lead."
      # redirect_to @listing
    end
  end

  def update
  end

  def destroy
  end
end



