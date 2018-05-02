json.extract! claim, :id, :facility_name, :date, :authorization_number, :total_requested_amount, :authorized_amount, :rejected_amount, :authority_name, :provider_id, :authority_designation, :member_number, :status, :insurer_id, :created_at, :updated_at
json.url claim_url(claim, format: :json)
