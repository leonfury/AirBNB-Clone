class MailingJob < ApplicationJob
  queue_as :default

  def perform(book, current_user)
    # Do something later
    BookingMailer.booking_mail(book, current_user).deliver_now
  end
end
