class ApplicationController < ActionController::Base
	include Pagy::Backend
	before_action :turbo_frame_request_variant
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:avatar])
  end

  def turbo_frame_request_variant
  	request.variant = :turbo_frame if turbo_frame_request?
  end
end
