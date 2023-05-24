class Admin::EventsController < ApplicationController
  include ApplicationHelper
  before_action :check_if_admin

  def index
    @events = Event.all.where(validated: nil)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if params['event'] == "true"
      @event.update(validated:true)
      flash[:notice] = "L'évènement a été accepté !"
      redirect_to admin_events_path
      
    else params['event'] == "false"
      @event.update(validated:false)
      flash[:notice] = "L'évènement a été refusé !"
      redirect_to admin_events_path
    end

  end

  private

end
