module ApplicationHelper

  def check_if_admin
    unless current_user&.is_admin
      flash[:alert] = "Action réservée aux administrateurs !"
      redirect_to root_path
    end
  end

  def bootstrap_class_for_flash(type)
    case type
      when 'notice' then "alert-info"
      when 'success' then "alert-success"
      when 'error' then "alert-danger"
      when 'alert' then "alert-warning"
    end
  end
end
