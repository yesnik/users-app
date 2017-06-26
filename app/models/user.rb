class User < ApplicationRecord
  validates :email, :firstname, :lastname, :birthdate, :biography, presence: true
  validates :password, presence: true, confirmation: true, if: proc { new_record? }
  validates :password_confirmation, presence: true, if: proc { new_record? }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"},
                             default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  scope :not_admin, -> { where(admin: false) }

  def full_name
    "#{firstname} #{lastname}" 
  end
end
