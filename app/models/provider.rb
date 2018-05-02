class Provider < ApplicationRecord

extend Dragonfly::Model
 
 include Avatarable
	

 mount_uploader :photo, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :claims, dependent: :destroy
         validates :company_name, :phone, :address, presence: true




  # required for avatarable
  def avatar_text
    company_name.chr
  end


end



