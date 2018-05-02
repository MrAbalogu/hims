module ApplicationHelper


    def total_cost(service)
        unit_cost = service.cost
        qty = service.qty 
        total_cost = unit_cost * qty

        total_cost.to_i
    end


    def user_avatar(user, options = {})
        if user.photo.file.nil?
          image_tag user.avatar_url, options
        else
          image_tag user.photo.thumb.url, options
        end
  end


    def total_claim_cost(claim)
        total_cost = 0
        claim.services.each do |service|
            service_unit_cost = service.cost
            qty  = service.qty
            service_total_cost = service_unit_cost * qty
            total_cost += service_total_cost
        end

        total_cost

    end

    def get_claim_status_code(status)

        val = 'label-default'
        if status == 0
            val
        elsif status == 1
            val = 'label-info'
        elsif status == 2
            val = 'label-success'
        elsif status == 3
            val = 'label-warning'
        else
            val
        end

        val
    end

    #count of submitted claims pending with insurance company
    def pending_claims_count
        counter = ""
        insurer = current_insurer
        counter = insurer.claims.where(status: 1).count
        
        if counter < 1
            counter = ""
        else
            counter
        end
        counter

    end


    #sets the label color depending on the selected filter
    def get_insurer_claims_status_code(filter)
        status = 'label-default'
        if @filter == 'pending'
            status = 'label-info'
        elsif @filter == 'vetted'
            status = 'label-success'
        elsif @filter == 'rejected'
            status = 'label-warning'
        elsif @filter == 'all'
            status = 'label-success'
        else
            status
        end

        status
    end

    def get_claim_status_text(status)

        val = 'Pending'
        if status == 0
            val
        elsif status == 1
            val = 'Submitted'
        elsif status == 2
            val = 'Approved'
        elsif status == 3
            val = 'Rejected'
        else 
            val
        end

        val
    end

end
