class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
include Pundit::Authorization
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_locale

private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale

  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
    parsed_locale.to_sym :
    nil
  end

def user_not_authorized
  flash[:alert] = "You are not authorized to perform this action."
  redirect_to(request.referrer || root_path)
end 
 protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :language])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :language])
  end

end



