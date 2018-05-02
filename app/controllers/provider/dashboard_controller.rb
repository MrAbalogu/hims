class Provider::DashboardController < ApplicationController
 
  layout 'dashboard'

  before_action :authenticate_provider!
  
  
  def index
        @enrolees = Enrolee.where('primary_provider LIKE ?', "%#{current_provider.company_name}%").limit(10)
         @total_claims = current_provider.claims
         @total_enrolees = Enrolee.where(primary_provider: current_provider.company_name)
 
  end

  def panelist


      @insurers = Insurer.all

      @enrolees = Enrolee.where('primary_provider LIKE ?', "%#{current_provider.company_name}%")


    if !params[:enrolee_number].blank?
      enrolee_list = @enrolees.where('enrolee_number LIKE ?', "%#{params[:enrolee_number]}%")
          flash[:success] = 'Search Completed Successfully.'

    elsif !params[:name].blank?
      enrolee_list = @enrolees.where('firstname LIKE ?', "%#{params[:name]}%")
            flash[:success] = 'Search Completed Successfully.'

          if !enrolee_list.any?
            enrolee_list = @enrolees.where('lastname LIKE ?', "%#{params[:name]}%")
          end

    elsif !params[:insurer_name].blank?
        insurer = Insurer.find_by_company_name(params[:insurer_name])

        if !insurer.nil?
             enrolee_list = insurer.enrolees.where('primary_provider LIKE ?', "%#{current_provider.company_name}%")
              flash[:success] = 'Search Completed Successfully.'
          end

    else
      enrolee_list = @enrolees
    end

      if enrolee_list.nil?
         flash[:notice] = "No result found"
          @enrolees = Enrolee.where(primary_provider: current_provider.company_name).paginate(:page => params[:page], :per_page => 15).order('id DESC')

      else 
           @enrolees = enrolee_list.paginate(:page => params[:page], :per_page => 15).order('id DESC')   
      end

    respond_to do |format|
      format.html{}
      format.js
    end





  end





  def view_provider_enrolee
      @enrolee = Enrolee.find(params[:enrolee_id])

  end

end
