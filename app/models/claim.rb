class Claim < ApplicationRecord
  belongs_to :provider
  belongs_to :insurer
  
  mount_uploaders :attachments, AttachmentUploader

  has_many :services, dependent: :destroy

  validates :authority_name, :authority_designation, :member_name, :member_number, presence: true
end
