class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    if user.admin?
      users_path
    else
      pages_welcome_path
    end
  end
end
