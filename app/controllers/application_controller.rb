class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def clear_cache
    Rails.cache.clear
  end

  private
  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to access this section."
      redirect_to panels_index_path
    end
  end

  def require_leader
    unless current_user&.leader?
      flash[:alert] = "You must be a leader to access this section."
      redirect_to panels_index_path
    end
  end

  def require_technician
    unless current_user&.technician?
      flash[:alert] = "You must be a technician to access this section."
      redirect_to panels_index_path
    end
  end

  def require_admin_or_leader
    unless current_user&.admin? || current_user&.leader?
      flash[:alert] = "You must be an admin or a leader to access this section."
      redirect_to panels_index_path
    end
  end
end
