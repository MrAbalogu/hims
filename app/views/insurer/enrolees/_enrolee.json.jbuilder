json.extract! enrolee, :id, :suraname, :firstname, :middlename, :company, :enrolee_number, :primary_provider, :secondary_provider, :tertiary_provider, :phone, :email, :address, :dob, :sex, :state, :cover_status, :card_issued, :plan, :expiry_date, :photo, :created_at, :updated_at
json.url enrolee_url(enrolee, format: :json)
