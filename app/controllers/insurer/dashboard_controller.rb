class Insurer::DashboardController < ApplicationController

  layout 'dashboard'

  def index
  	   @enrolees = current_insurer.enrolees.limit(10).order('created_at DESC')
  	   @total_claims = current_insurer.claims
  	   @total_enrolees = current_insurer.enrolees
    
  end
end
