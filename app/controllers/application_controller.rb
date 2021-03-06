class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource)
    root_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role,:avatar, :avatar_cache, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role,:avatar, :avatar_cache, :remove_avatar, :email, :password])

  end
end
