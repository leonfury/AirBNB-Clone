class BookingMailer < ApplicationMailer

    def booking_mail(reservation, book_by_user) 
        @book = reservation
        @booker = book_by_user
        mail(to: @book.user.email, subject: 'Testing Book Mail')
    end
    
end
