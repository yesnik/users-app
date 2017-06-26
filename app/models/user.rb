class User < ApplicationRecord
  validates :email, :firstname, :lastname, :birthdate, :biography, presence: true
  validates :password, presence: true, confirmation: true, if: proc { new_record? }
  validates :password_confirmation, presence: true, if: proc { new_record? }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :not_admin, -> { where(admin: false) }

  def full_name
    "#{firstname} #{lastname}" 
  end
end
