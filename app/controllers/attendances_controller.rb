class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.new
    @event = Event.find(params['event_id'])
  end

  def index
    @event = Event.find(params['event_id'])
  end
end
