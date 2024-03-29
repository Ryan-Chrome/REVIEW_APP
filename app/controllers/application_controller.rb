class ApplicationController < ActionController::Base
  before_action :config_permitted_parameters, if: :devise_controller?

  def config_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :admin, :image])
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def login_user
    redirect_to new_user_session_path unless user_signed_in?
  end
end
