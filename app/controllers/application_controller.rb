class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :ph_link

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  add_breadcrumb "Home", :root_path

# Taken from Pundit page
#  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected
  def ph_link name
    name = name.to_sym
    {
      home: 'https://station.locomotive.works/_app/vit/preview/',
      lib: 'http://lib.physcon.ru',
      cap: 'http://cap.physcon.ru',
      coms: 'http://coms.physcon.ru',
      my: 'https://ph4-my-vit2.c9users.io/'
    }[name]
  end

	def set_locale
		#I18n.locale = params[:locale] || I18n.default_locale
		I18n.locale = extract_locale_from_accept_language_header
	end
 
	def extract_locale_from_accept_language_header
		request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
	end


  def configure_permitted_parameters
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname])
    devise_parameter_sanitizer.for(:sign_up)        << :fname << :mname << :lname
    #devise_parameter_sanitizer.for(:sign_in)        << :username
    devise_parameter_sanitizer.for(:account_update)        << :fname << :mname << :lname
  end


# Taken from Pundit page
# def user_not_authorized(exception)
#   policy_name = exception.policy.class.to_s.underscore
#   flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
#   redirect_to(request.referrer || root_path)
# end


end

