class Attendance < ApplicationRecord
  after_create :attendance_send

  belongs_to :attendee, class_name: "User"
  belongs_to :event

  def attendance_send
    AttendanceMailer.attendance_email(self).deliver_now
  end

end
