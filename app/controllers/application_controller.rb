class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_up_path_for(resource)
    if resource.errors.empty?
      categories_path
    else
      # Redirect to the registration page with errors displayed
      new_user_registration_path
    end
  end

  def after_sign_in_path_for(_resource)
    categories_path
  end
end
