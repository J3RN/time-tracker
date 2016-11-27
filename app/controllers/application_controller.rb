class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_)
    tasks_path
  end

  protected

  def configure_permitted_parameters
    additional_fields = User::ADDITIONAL_FIELDS
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_fields)
    devise_parameter_sanitizer.permit(:account_update, keys: additional_fields)

    return unless user_signed_in? && current_user.admin?

    devise_parameter_sanitizer.for(:account_update, keys: [:admin])
  end

  def ensure_ownership(item)
    return if item.user == current_user || current_user.admin?

    redirect_to({ action: 'index' }, alert: "That's not yours!")
  end
end
