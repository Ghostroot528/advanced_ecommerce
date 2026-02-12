class ApplicationController < ActionController::Base
  # ❌ DO NOT force authentication globally
  # before_action :authenticate_user!

  protected

  def require_login!
    authenticate_user!
  end

  def require_admin!
    authenticate_user!
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied (admin only)"
    end
  end
end
