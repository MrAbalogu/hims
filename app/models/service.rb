class Service < ApplicationRecord

    belongs_to :claim


    validates :name, :claim_id, :service_type, :qty, :cost, presence: true
    
end
