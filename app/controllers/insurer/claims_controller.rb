class Insurer::ClaimsController < ApplicationController


  include ApplicationHelper

  before_action :set_claim, only: [:show, :edit, :update, :destroy, :preview, :invoice_generation, :submit]

  layout 'dashboard'

  # GET /claims
  # GET /claims.json

  before_action :authenticate_insurer!, only: [:index, :edit]

  require 'rubyXL'

  def index
    if params[:filter] == 'pending'
        @filter = 'pending'
      @claims = current_insurer.claims.where(status: 1).order("created_at desc")
    elsif params[:filter] == 'vetted'
        @filter = 'vetted'
        @claims = current_insurer.claims.where(status: 2).order("created_at desc")
    elsif params[:filter] == 'rejected'
        @filter = 'rejected'
        @claims = current_insurer.claims.where(status: 3).order("created_at desc")
    else
      @filter = 'all'
      @claims = current_insurer.claims.all.order("created_at desc")
    end


  end

  # GET /claims/new
  def new
    @claim = current_insurer.claims.new   
   
  end

  # POST /claims
  # POST /claims.json
  def create
    @claim = current_insurer.claims.build(claim_params)

    respond_to do |format|
      if @claim.save
        format.html { redirect_to addService_insurer_claim_path(id: @claim.id), notice: 'Claim was successfully created.' }
        format.json 
      else
        format.html { render :new }
        format.json 
      end
    end
  end

  def addService
    @claim = Claim.find(params[:id])
    @drug_list_options = get_drug_list_options
    @service_list_options = get_service_list_options

    #generating a new claim number
      new_claim_no = generate_claim_code(@claim)
      @claim.update(claim_no: new_claim_no)
  end
  




  def vet
    claim_id = params[:claim_id]
    @claim = current_insurer.claims.find(claim_id)
     @attachment_count = @claim.attachments.count


  end

  def submit_vetted
    claim = current_insurer.claims.find(params[:claim_id])
    service_count = claim.services.count

    params.keys.each do |param|
      if param.include?('vc')
          id = param.split('-').second.to_i
          service  = claim.services.find(id)
          service.update(vetted_cost: params[param])
      end
    end


    #updated vetted_total
    vetted_total = params[:vetted_total]
    insurer_comment = params[:insurer_comment]

    if claim.update(authorized_amount: vetted_total, status: 2, insurer_comment: insurer_comment)
      flash[:success] = 'This claim was vetted successfully'
      redirect_to invoice_generation_insurer_claim_path
    else
      flash[:error] = 'An error occured when vetting this claim amounts. please try again'
      redirect_to vet_insurer_claim_path
    end

  end

  # def auto_vetting

  #    claim_id = params[:claim_id]
  #   @claim = current_insurer.claims.find(claim_id)
  #    @attachment_count = @claim.attachments.count

  #         drug_list_workbook = RubyXL::Parser.parse("druglist.xlsx")
  #         service_list_workbook = RubyXL::Parser.parse("servicex.xlsx")

  #         drug_list_worksheet = drug_list_workbook.worksheets[0]
  #         service_list_worksheet = service_list_workbook[0]

  #         recommended_costs = []

  #         @claim.services.each do |service|

  #           if service.type == "DRUG"
  #              drug_list_worksheet.each do |row|
  #                 if !row[1].nil? #checking if the second column(1) of row is nil . remember reading starts from 0
  #                   val = row[1].value.to_s
  #                   if val == service.name 
  #                       recommended_costs[service.id] = row[2]
  #                       option = "#{'<option value='+val+'>' + val + '</option>'}"

  #                       options << option #add the new option tag to the options variable
  #                 end
                    

  #               end
  #             requested_cost = service.cost

              
  #             recommended_cost

  #        end




  # end

  # GET /claims/1
  # GET /claims/1.json
  def show
     @attachment_count = @claim.attachments.count

  end

  def invoice_generation


  end

  def generate_invoice
    @claim = Claim.find(params[:claim_id])

    respond_to do |format|
          format.html
          format.pdf do


             render pdf:  "claim_invoice_MFN/2018/CLM/1000#{@claim.id}",
               template:     'insurer/claims/generate_invoice.html.erb',
               layout:       'layouts/invoice',
               title:        "Download invoice",
               show_as_html: false,
               margin: { top: 10, bottom: 10 },
               background: true
          end
    end
  end

  

  # GET /claims/1/edit
  def edit
  end


  # PATCH/PUT /claims/1
  # PATCH/PUT /claims/1.json
 def update
    respond_to do |format|
      if @claim.update(claim_params)
        format.html { redirect_to @claim, notice: 'Claim was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js { render 'addService' }
      end
    end
  end

  # DELETE /claims/1
  # DELETE /claims/1.json
  def destroy
    @claim.destroy
    respond_to do |format|
      format.html { redirect_to insurer_claims_url, notice: 'Claim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    check_services(@claim)
     @attachment_count = @claim.attachments.count

  end


   def submit
    
    check_services(@claim)

    total_requested_cost = total_claim_cost(@claim)
    if @claim.update(status: 1, total_requested_amount: total_requested_cost)
       flash[:success] = 'Successfully submitted claim for Vetting'
       redirect_to insurer_claims_path
    else
      flash[:error] =  'There was an error submitting this claim. please try again or contact your IT desk'
      redirect_to preview_insurer_claim_path(@claim) 
    end
   
  end


private
    # Use callbacks to share common setup or constraints between actions.
 
    def check_services(claim)
      if claim.services.count < 1 
        flash[:error] = "Kindly add a service to this claim to continue"
        redirect_to addService_insurer_claim_path(claim)
      end

    end

    def get_drug_list_options 


      print Rails.root.join('druglist.xlsx')
      drug_list_workbook = RubyXL::Parser.parse("druglist.xlsx")

      drug_list_worksheet = drug_list_workbook.worksheets[0]

      options = ""


      drug_list_worksheet.each do |row|
        if !row[1].nil? #checking if the second column(1) of row is nil . remember reading starts from 0
          val = row[1].value.to_s
              option = "#{'<option value='+val+'>' + val + '</option>'}"

              options << option #add the new option tag to the options variable
        end
          

      end

      options

  end



  def get_service_list_options 

    print Rails.root.join('servicex.xlsx')
    service_list_workbook = RubyXL::Parser.parse("servicex.xlsx")

    service_list_worksheet = service_list_workbook.worksheets[0]

    options = ""


      service_list_worksheet.each do |row|
        if !row[2].nil?
          val = row[2].value.to_s
          option = "#{'<option value='+val+'>' + val + '</option>'}"

              options << option
        end
          

      end

      options

end


def generate_claim_code(claim)

    claim_id = claim.id.to_s
    claim_year = claim.created_at.year.to_s

    a = current_insurer.company_name.split(' ').first[0,1]
    b = current_insurer.company_name.split(' ').second[0,1]
    c = current_insurer.company_name.split(' ').third

    if !c.nil?
      c = c[0,1]

      claim_code = "#{a+b+c}/#{claim_year}/CLM/000#{claim_id}"
    else
      claim_code = "#{a+b}/#{claim_year}/CLM/000#{claim_id}"
    end

    claim_code

end




def set_claim
  @claim = Claim.find(params[:id])
end






    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:facility_name, :date, :authorization_number, :total_requested_amount, :authorized_amount, :rejected_amount, :authority_name, :provider_id, :authority_designation, :member_number, :member_name, :status, :insurer_id)
    end

end