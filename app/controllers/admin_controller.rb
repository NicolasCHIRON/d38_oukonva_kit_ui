class AdminController < ApplicationController
  include ApplicationHelper
  before_action :check_if_admin

  def index

  end

  private

end
