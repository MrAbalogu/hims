class Dependant < ApplicationRecord

	belongs_to :enrolee

	validates :surname, :firstname, :primary_hospital, presence: true

	validates_uniqueness_of :enrolee_number

 	require 'csv'


 def self.import(file, company_name, insurer_id)
 		company_id  = Company.find_by_name(company_name).id
 		counter = 0

 		CSV.foreach(file.path, headers: true) do |row|

 		principal_num = "#{row['principal_number']}"


 		puts principal_number = principal_num.to_s

 		
 		enrolee = Enrolee.find_by_enrolee_number("#{principal_number}")


	 		if enrolee.nil? 
	 			puts 'no enrolee found with that principal enrolment id'

	 		else


		 		enrolee_id = enrolee.id

				  t = Dependant.new
				  t.insurer_id = insurer_id
				  t.enrolee_id = enrolee_id
				  t.plan = row['plan']
				  t.surname = row['surname']
				  t.firstname = row['firstname']
				  t.middlename = row['middlename']
				  t.enrolee_number = row['enrolee_number']
				  t.primary_hospital = row['primary_hospital']
				  t.phone = row['phone']
				  t.dob = row['dob']
				  t.dependant_type = row['dependant_type']
				  t.sex = row['sex']
				  t.location = row['location']
				  t.card_issued = row['card_issued']
				  t.expiry_date = Time.now+1.year
				  t.save
				  puts "#{t.surname}, #{t.firstname}"
				  counter = counter+1
			end
		end

		puts "#{counter} new rows added to the dependants table"
 end



end
