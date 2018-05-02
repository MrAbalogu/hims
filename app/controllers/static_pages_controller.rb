class StaticPagesController < ApplicationController
  
  def home
    if insurer_signed_in? 
      flash[:success] = "Welcome to your dashboard"
      redirect_to insurer_dashboard_path
    elsif provider_signed_in?
      flash[:success] = "Welcome to your dashboard"
    else

    end
  end

  def about
  end

  def contact
  end

  def dashboard
    if insurer_signed_in? 
      @enrolees = current_insurer.enrolees.limit(10)
      flash[:success] = "Welcome to your dashboard"
      redirect_to insurer_dashboard_path
    elsif provider_signed_in?

      flash[:success] = "Welcome to your dashboard"
      redirect_to provider_dashboard_path
    else

    end
  end
  
end
