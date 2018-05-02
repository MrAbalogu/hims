class Plan < ApplicationRecord

	validates :name, :description, :insurer_id, presence: true

	belongs_to :insurer
end
