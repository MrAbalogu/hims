module ClaimsTotal
    extend ActiveSupport::Concern

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
  end