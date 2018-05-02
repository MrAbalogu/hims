json.extract! dependant, :id, :surname, :firstname, :middlename, :dob, :sex, :blood_group, :primary_hospital, :secondary_hospital, :genotype, :photo, :enrolee.references, :created_at, :updated_at
json.url dependant_url(dependant, format: :json)
