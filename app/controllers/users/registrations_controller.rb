class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super.new
  end
end