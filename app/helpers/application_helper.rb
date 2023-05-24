module ApplicationHelper

  def check_if_admin
    unless current_user&.is_admin
      flash[:alert] = "Action réservée aux administrateurs !"
      redirect_to root_path
    end
  end

end
