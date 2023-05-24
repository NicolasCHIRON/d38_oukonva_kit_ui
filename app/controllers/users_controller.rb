class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :authenticate_administrator

  def show
    @user = User.find(params['id'])
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter pour voir votre profil"
      redirect_to new_user_session_path
    end
  end

  def authenticate_administrator
    unless current_user == User.find(params['id'])
      flash[:alert] = "Vous ne pouvez accéder qu'à votre profil"
      redirect_to root_path
    end
  end

end
