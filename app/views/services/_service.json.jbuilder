json.extract! service, :id, :type, :name, :cost, :qty, :description, :claim.references, :created_at, :updated_at
json.url service_url(service, format: :json)
