class Insurer::DependantsController < ApplicationController
  before_action :set_dependant, only: [:show, :edit, :update, :destroy]

  # GET /dependants
  # GET /dependants.json
  def index
    @dependants = Dependant.all
  end

  # GET /dependants/1
  # GET /dependants/1.json
  def show
  end

  # GET /dependants/new
  def new (enrolee_id)
    enrolee = Enrolee.find(enrolee_id)
    @dependant = enrolee.dependants.build
  end

  def dependant_card_issued(dependant)

  end

 
  def data_upload
    @insurer = current_insurer

  end

  def populatedb
     @insurer = current_insurer
    file = params[:dependants_list]
    company_name = params[:company_name]
    insurer_id = current_insurer.id

    Dependant.import(file, company_name, insurer_id)

    flash[:success] = "Dependants Data successfully uploaded to database"
    redirect_to insurer_enrolees_path

  end


  # GET /dependants/1/edit
  def edit
  end

  # POST /dependants
  # POST /dependants.json
  def create

    @enrolee = current_insurer.enrolees.find(params[:dependant][:enrolee_id])
    @dependant = @enrolee.dependants.new(dependant_params)

     generate_number = generate_dependant_enrolee_number(@dependant, @enrolee)
     @dependant.enrolee_number = generate_number
   

    respond_to do |format|
      if @dependant.save
        format.html { redirect_to insurer_enrolee_path(@dependant.enrolee), notice: 'Dependant was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /dependants/1
  # PATCH/PUT /dependants/1.json
  def update
    respond_to do |format|
      if @dependant.update(dependant_params)
        format.html { redirect_to insurer_enrolee_path(@dependant.enrolee), notice: 'Dependant was successfully updated.' }
        format.json { render :show, status: :ok, location: @dependant }
      else
        format.html { render :edit }
        format.json { render json: @dependant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dependants/1
  # DELETE /dependants/1.json
  def destroy
    @enrolee = @dependant.enrolee
    @dependant.destroy
    respond_to do |format|
      format.html { redirect_to insurer_dependants_url, notice: 'Dependant was successfully destroyed.' }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dependant
      @dependant = Dependant.find(params[:id])
    end


    def generate_dependant_enrolee_number(dependant, enrolee)


      e_number = enrolee.enrolee_number

      if dependant.dependant_type == "spouse"
        d_number = e_number + 'S'
      elsif dependant.dependant_type == "child"
        child_dependants = enrolee.dependants.where(dependant_type: 'child')
        if child_dependants.any?
          child_count = child_dependants.count 
          new_count = child_count+1
          new_count = new_count.to_s
        else
          new_count = 1.to_s
        end

        d_number = e_number+"C"+new_count

      else 
        puts "Unrecognized dependant type"

      end
      puts d_number
      d_number
     

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dependant_params
      params.require(:dependant).permit(:surname, :firstname, :dependant_type, :middlename, :dob, :sex, :blood_group, :primary_hospital, :secondary_hospital, :genotype, :photo, :enrolee_id, :insurer_id)
    end
end
