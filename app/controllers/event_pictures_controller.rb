class EventPicturesController < ApplicationController
  # validates :event_picture, presence:true, content_type: [:gif, :png, :jpg, :jpeg], size: {less_than: 2.megabytes, message: "L'image doit avoir une taille inférieure à 2 MB."}

  def create
    @event = Event.find(params[:event_id])
    @event.event_picture.attach(params[:event_picture])
    redirect_to(event_path(@event))
  end
end
