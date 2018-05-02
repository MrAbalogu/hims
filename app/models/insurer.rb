class Insurer < ApplicationRecord

extend Dragonfly::Model
 
 include Avatarable

 mount_uploader :photo, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :claims, dependent: :destroy

  has_many :enrolees

  has_many :companies, dependent: :destroy

  has_many :plans, dependent: :destroy

  validates :company_name,  :address, :phone, :description, presence: true


  # required for avatarable
  def avatar_text
    company_name.chr
  end

end
