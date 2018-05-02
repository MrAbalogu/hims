require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'providers_filtered.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Provider.new
  t.company_name = row['provider_name']
  t.address = row['provider_address']
  t.phone = row['provider_phone']
  t.email = row['provider_email']
  t.password = row['provider_password']
  t.password_confirmation = row['provider_password_conf']
  t.save
  puts "#{t.company_name}, #{t.address} saved"
end

puts "There are now #{Provider.count} rows in the providers table"