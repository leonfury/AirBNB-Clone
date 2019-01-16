class BookingsController < ApplicationController
    def index
        @bookings = Booking.where(book_by: c_user_id)
    end
    
    def create
        listing = Listing.find(params[:listing_id])
        book = Booking.new(booking_params)
        if !availability(params[:booking][:check_in].to_date, params[:booking][:check_out].to_date, listing.bookings)
            flash[:error] = "Booking FAILED"
        else
            book.price = total_price(params[:booking][:check_in], params[:booking][:check_out], listing.price)
            book.book_by = c_user_id
            book.listing_id = listing.id
            book.user_id = listing.user_id
            book.save
            flash[:success] = "Booking Created Successfully"
        end
    end


    def availability(c_in, c_out, bookings)    
        bookings.each do |b|        
            if b.check_in >= c_in && c_in <= b.check_out            
                return false
            end
            if b.check_in >= c_out && c_out <= b.check_out         
                return false
            end 
        end    
        true
    end

    private
    def booking_params
        params.require(:booking).permit(
          :check_in, 
          :check_out,
          :price,
          :book_by, 
          :booking_status, 
          :listing_id,
          :user_id
        )
      end 
end
