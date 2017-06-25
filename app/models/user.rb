class User < ApplicationRecord
  validates :email, :password, :firstname, :lastname, :birthdate, :biography, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :not_admin, -> { where(admin: false) }

  def full_name
    "#{firstname} #{lastname}" 
  end
end
