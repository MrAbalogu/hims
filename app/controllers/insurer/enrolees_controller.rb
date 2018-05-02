class Insurer::EnroleesController < ApplicationController
  before_action :set_enrolee, only: [:show, :edit, :update, :destroy]


  layout 'dashboard'
  # GET /enrolees
  # GET /enrolees.json
  def index

    enrolees = current_insurer.enrolees

    if !params[:enrolee_number].blank?
      enrolee_list = enrolees.where('enrolee_number LIKE ?', "%#{params[:enrolee_number]}%")
          flash[:success] = 'Search Completed Successfully.'

    elsif !params[:name].blank?
      enrolee_list = enrolees.where('firstname LIKE ?', "%#{params[:name]}%")
            flash[:success] = 'Search Completed Successfully.'

      if !enrolee_list.any?
        enrolee_list = enrolees.where('lastname LIKE ?', "%#{params[:name]}%")
      end
    elsif !params[:company_name].blank?
      company = Company.where('name LIKE ?', "%#{params[:company_name]}%")

        if company.any?
         enrolee_list =  company.first.enrolees
         flash[:success] = "Search Completed Successfully"
       else
          enrolee_list = nil
       end
    elsif !params[:plan].blank?
      enrolee_list = enrolees.where('plan_name LIKE ?', "%#{params[:plan_name]}%")
          flash[:success] = 'Search Completed Successfully.'

    elsif !params[:provider_name].blank?
      enrolee_list = enrolees.where('primary_provider LIKE ?', "%#{params[:provider_name]}%")
          flash[:success] = 'Search Completed Successfully.'

    else
      enrolee_list = enrolees
    end

      if enrolee_list.nil?
         flash[:notice] = "No result found"
          @enrolees = current_insurer.enrolees.paginate(:page => params[:page], :per_page => 15).order('id DESC')

      else 
           @enrolees = enrolee_list.paginate(:page => params[:page], :per_page => 15).order('id DESC')   
      end

    respond_to do |format|
      format.html{}
      format.json { render json: UserDatatable.new(view_context) }
    end
   
  end


  def show_dependants
   @enrolee = Enrolee.find_by_id(params[:enrolee_id])
    respond_to do |format|
       format.js {render 'show_dependants'}
    end

  end


  def data_upload


  end

  def populatedb
     @insurer = current_insurer
    file = params[:enrolees_list]
    company_name = params[:company_name]
    insurer_id = current_insurer.id

    Enrolee.import(file, company_name, insurer_id)

    flash[:success] = "Data successfully uploaded to database"
    redirect_to insurer_enrolees_path

  end


  def quicksearch

    @enrolees = Enrolee.all
    respond_to do |format|
      format.html{}
      format.json { render json: UserDatatable.new(view_context) }
    end
   

  end

  # GET /enrolees/1
  # GET /enrolees/1.json
  def show
  end

  # GET /enrolees/new
  def new

    if (current_insurer.plans.count < 1) || (current_insurer.companies.count < 1)
      flash[:success] = "Kindly add Plans and Companies before adding enrolees. "
      redirect_to insurer_dashboard_path

    else
        @enrolee = Enrolee.new
        companies = current_insurer.companies
        # @your_companies = companies.sort.reverse.map { |a| [a.name, a.id] }

        plans = current_insurer.plans
        # @your_plans = plans.sort.reverse.map { |p| [p.name, p.id] }
    end
  end

  # GET /enrolees/1/edit
  def edit
  end

  # POST /enrolees
  # POST /enrolees.json
  def create

    @enrolee = Enrolee.new(enrolee_params)

    @enrolee.insurer_id = current_insurer.id
    @enrolee.enrolee_number = generate_enrolee_number(@enrolee)

    respond_to do |format|
      if @enrolee.save
        format.html { redirect_to addDependant_insurer_enrolee_path(id: @enrolee.id), notice: 'Enrolee was successfully created. Kindly Add Dependants' }
        format.json { render :show, status: :created, location: @enrolee }
      else
        format.html { render :new }
        format.json { render json: @enrolee.errors, status: :unprocessable_entity }
      end
    end
  end


  def addDependant
     @enrolee = current_insurer.enrolees.find(params[:id])
  end

  def preview
    flash[:success] = "Enrolee record saved successfully. "
    redirect_to new_insurer_enrolee_path
    
  end

  # PATCH/PUT /enrolees/1
  # PATCH/PUT /enrolees/1.json
  def update
    respond_to do |format|
      if @enrolee.update(enrolee_params)
        format.html { redirect_to insurer_enrolee_path(@enrolee), notice: 'Enrolee Details was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrolee }
      else
        format.html { render :edit }
        format.json { render json: @enrolee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrolees/1
  # DELETE /enrolees/1.json
  def destroy
    @enrolee.destroy
    respond_to do |format|
      format.html { redirect_to insurer_enrolees_url, notice: 'Enrolee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrolee
      @enrolee = Enrolee.find(params[:id])
    end

    def generate_enrolee_number(enrolee)
      year = Date.current.year.to_s
      plan = enrolee.plan
      plan_name = plan.upcase

      last_enrolee_on_current_plan = current_insurer.enrolees.where(plan: plan)

      if last_enrolee_on_current_plan.any?
          last_code_on_current_plan = last_enrolee_on_current_plan.last.id
        else
          last_code_on_current_plan = 0
        end

      code = last_code_on_current_plan+1

      code = code.to_s

      new_enrolee_number = "#{'MFN/'+year+'/'+plan_name+'/000'+code}" 

      new_enrolee_number
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrolee_params
      params.require(:enrolee).permit(:surname, :firstname, :middlename, :company_id, :company_name, :insurer_id, :enrolee_number, :primary_provider, :secondary_provider, :tertiary_provider, :phone, :email, :address, :dob, :date, :sex, :state, :cover_status, :location, :card_issued, :plan, :expiry_date, :photo)
    end
end
