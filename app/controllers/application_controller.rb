class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :basic_auth, if: :production?
  # before_action :authenticate_user!　ビュー編集のため一時的にコメントアウト
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :family_name, :hurigana_first, :hurigana_family, :birthday])
  end

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] &&
      password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  def production?
    Rails.env.production?
  end
end
