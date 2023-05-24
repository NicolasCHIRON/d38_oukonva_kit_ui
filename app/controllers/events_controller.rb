class EventsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user, only: [:new, :create, :show]
  before_action :authenticate_administrator, only: [:edit, :update, :destroy]
  before_action :check_if_admin, only: [:update_true, :update_false]

  def index
    # Ne montrer que les évènements validés
    @events = Event.all.where(validated: true)
  end

  def show
    @event = Event.find(params['id'])
    if @event.attendances.count > 0 && @event.attendances.find_by(attendee_id: current_user)
      @registered = true
    else
      @registered = false
    end

  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(start_date: params['event']['start_date'],
      duration: params['event']['duration'].to_i, 
      title: params['event']['title'], 
      description: params['event']['description'],
      location: params['event']['location'],
      administrator_id: current_user.id,
      price: params['event']['price'].to_i)
    if (@event.save && params[:event][:event_picture])
      @event.event_picture.attach(params[:event][:event_picture])
      flash[:notice] = "L'évènement a bien été créé !"
      redirect_to '/'
    else
      flash[:alert] = "Erreur lors de la création de l'évènement."
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @event = Event.find(params['id'])
  end

  def update
    @event = Event.find(params['id'])
      if @event.update(params.require(:event).permit(:start_date, :duration, :title, :description, :location, :price))
        flash[:notice] = "Votre évènement a bien été mis à jour !"
        redirect_to @event
      else
        flash[:alert] = @event.errors.full.messages[0]
        render 'edit'
      end
  end

  def destroy
    @event = Event.find(params['id'])
    @event.destroy
    flash[:notice] = "L'évènement a été supprimé"
    redirect_to root_path
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter pour voir les évènements."
      redirect_to new_user_session_path
    end
  end

  def authenticate_administrator
    unless current_user == Event.find(params['id']).administrator
      flash[:alert] = "Vous ne pouvez modifier que vos évènements"
      redirect_to root_path
    end
  end

end
