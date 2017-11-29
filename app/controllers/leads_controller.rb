class LeadsController < ApplicationController
  def index
  end

  def create
    @lead = Lead.new(lead_params)
    @lead.user = current_user
    @lead.person = params[:user_id]

    if @lead.save
      # Redirect
      # redirect_to @booking
      flash[:alert] = "Lead added"
    else
      flash[:alert] = "We couldn't add the Lead."
      # redirect_to @listing
    end
  end

  def update
  end

  def destroy
  end



private

  def lead_params
    params.require(:lead).permit(:user_id)
  end

end


# POST user_leads_path(user.id)


# /users/:user_id/leads
