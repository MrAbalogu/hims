module Accessible
    extend ActiveSupport::Concern
    included do
      before_action :check_user
    end
  
    protected
    def check_user
      if current_provider
        flash.clear
        redirect_to(dashboard_path) && return
      elsif current_insurer
        flash.clear
        redirect_to(dashboard_path) && return
      end
    end
  end