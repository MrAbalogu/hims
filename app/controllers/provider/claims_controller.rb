class Provider::ClaimsController < ApplicationController
  
  include ApplicationHelper

  before_action :set_claim, only: [:show, :edit, :update, :destroy, :preview, :submit]

  
  layout 'dashboard'
  # GET /claims
  # GET /claims.json

  before_action :authenticate_provider!, only: [:new, :edit]

  require 'rubyXL'

  def index
    if params[:filter] == 'pending'
      @claims = Claim.where(status: 0).order("created_at desc")
    else
      @claims = Claim.all.order("created_at desc")
    end
  end

  # GET /claims/1
  # GET /claims/1.json
  def show
     @attachment_count = @claim.attachments.count
  end

  # GET /claims/new
  def new
    if params[:enrolee_id]
      @enrolee = Enrolee.find_by_id(params[:enrolee_id])
      @claim = Claim.new
    else
      @enrolee = nil
      @claim = Claim.new
    end
   
    # service_list_workbook = RubyXL::Parser.parse("../asset/files/service_list.xlsx")
    # service_list_worksheet = service_list_workbook.worksheets[0]

  end

  def addService
    @claim = Claim.find(params[:id])
    @drug_list_options = get_drug_list_options
    @service_list_options = get_service_list_options


    #generating a new claim number
      new_claim_no = generate_claim_code(@claim)
      @claim.update(claim_no: new_claim_no)

  end

  # GET /claims/1/edit
  def edit
  end


  # POST /claims
  # POST /claims.json
  def create
    @claim = current_provider.claims.build(claim_params)
    respond_to do |format|
      if @claim.save
        format.html { redirect_to addService_provider_claim_path(id: @claim.id), notice: 'Claim was successfully created.' }
        format.json 
      else
        format.html { render :new }
        format.json 
      end
    end
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
      format.html { redirect_to provider_claims_url, notice: 'Claim was successfully destroyed.' }
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
       flash[:notice] = 'Successfully submitted claim to Insurer'
       redirect_to provider_claims_path
    else
      flash[:error] =  'There was an error submitting this claim. please try again or contact your IT desk'
      redirect_to preview_provider_claim_path(@claim) 
    end
   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
 
    def check_services(claim)
      if claim.services.count < 1 
        flash[:error] = "Kindly add a service to this claim to continue"
        redirect_to addService_provider_claim_path(claim)
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

    a = claim.insurer.company_name.split(' ').first[0,1]
    b = claim.insurer.company_name.split(' ').second[0,1]
    c = claim.insurer.company_name.split(' ').third

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
      params.require(:claim).permit(:facility_name, :date, :authorization_number, :total_requested_amount, :authorized_amount, :rejected_amount, :authority_name, :provider_id, :authority_designation, :member_number, :member_name, :status, :insurer_id, {attachments: []})
    end
end
