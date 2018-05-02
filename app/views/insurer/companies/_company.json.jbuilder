json.extract! company, :id, :name, :address, :plan, :contact, :created_at, :updated_at
json.url company_url(company, format: :json)
