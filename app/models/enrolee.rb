class Enrolee < ApplicationRecord


 include Avatarable

 require 'csv'

 mount_uploader :photo, AvatarUploader

 belongs_to :insurer

 belongs_to :company

 has_many :dependants, dependent: :destroy
 
 validates :surname, :insurer_id, :firstname, :company_id, :plan, presence: true
 validates_uniqueness_of :enrolee_number

 def self.import(file, company_name, insurer_id)
 		company_id  = Company.find_by_name(company_name).id
 		counter = 0

 	CSV.foreach(file.path, headers: true) do |row|
		  t = Enrolee.new
		  t.company_id = company_id
		  t.insurer_id = insurer_id
		  t.company_name = company_name
		  t.plan = row['plan']
		  t.surname = row['surname']
		  t.firstname = row['firstname']
		  t.middlename = row['middlename']
		  t.enrolee_number = row['enrolee_number']
		  t.primary_provider = row['primary_provider']
		  t.phone = row['phone']
		  t.email = row['email']
		  t.address = row['address']
		  t.dob = row['dob']
		  t.sex = row['sex']
		  t.location = row['location']
		  t.card_issued = row['card_issued']
		  t.expiry_date = Time.now+1.year
		  t.save
		  puts "#{t.surname}, #{t.firstname}"
		  counter = counter+1
	end
		puts "#{counter} new rows added to the enrolees table"
 end



end
