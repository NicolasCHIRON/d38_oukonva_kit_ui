class Admin::UsersController < ApplicationController
  before_action :check_if_admin

  def index
    @users = User.all
  end

  def destroy
    @user =User.find(params['id'])
    @user.delete
    flash[:alert] = "Compte supprimé !"
    redirect_to root_path
  end

  private

  def check_if_admin
    unless current_user&.is_admin
      flash[:alert] = "Action réservée aux administrateurs !"
      redirect_to root_path
    end
  end
end
