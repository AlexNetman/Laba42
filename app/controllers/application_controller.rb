# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :authenticate_user!, only: [:select_role, :edit]

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def select_role
    set_role if request.post?
  end

  def edit
    edit_info if request.post?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_role
    current_user.role = 0 if params[:role] == 0.to_s
    current_user.role = 1 if params[:role] == 1.to_s
    current_user.save!
    redirect_to '/edit'
  end

  def edit_info
    # methods from post params been later
    redirect_to '/'
  end
end
