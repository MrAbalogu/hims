class Company < ApplicationRecord

	belongs_to :insurer
	
	has_many :enrolees, dependent: :destroy

	validates :name, :insurer_id, presence: true

end
