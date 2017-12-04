class LeadsController < ApplicationController
  def index
    @leads = Lead.where(user_id: current_user)
  end

  def new
  end

  def create
    @person = User.find(params[:user_id])
    # TODO CHECK IF LEAD ALREADY EXIST
    @company = @person.company
    @lead = Lead.new(user: current_user, person: @person)
    if @lead.save
      respond_to do |format|
        format.html { redirect_to company_path(@company) }
        format.js # render create.js.erb
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = "We couldn't add the Lead."
          render "companies/show"
        }
        format.js
      end
    end
  end

  # def update
  #   @lead = Lead.find(params[:lead_id])
  #   if @lead.save
  #     respond_to do |format|
  #       format.js
  #   else
  #       format.html { render action: "edit" }
  #       format.js
  #     end
  #   end
  # end


    def update
      @lead = Lead.find(params[:id])
      respond_to do |format|
        if @lead.update(status: params[:status])
          format.html { redirect_to @leads, notice: 'successfully updated.' }
          format.js { head :ok, content_type: "text/html"}
        else
          format.html { render action: "edit" }
          format.js { head :ok, content_type: "text/html"}
        end
      end

    end


  def destroy
    # /leads/:id/destroy
    @lead = Lead.find(params[:id])
    @lead.destroy
    respond_to do |format|
      format.js
    end
  end
end



