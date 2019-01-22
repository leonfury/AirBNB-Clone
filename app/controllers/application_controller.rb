class ApplicationController < ActionController::Base
    include Clearance::Controller
    helper_method :c_user_id
    helper_method :user_name
    helper_method :local_time
    helper_method :is_member?
    helper_method :is_moderator?
    helper_method :is_admin?
    helper_method :total_night
    helper_method :total_price
    helper_method :availability_calendar
    def c_user_id
        current_user.id
    end

    def user_name
        current_user.first_name
    end

    def local_time(date)
        z = date + 28800
        z.to_date
    end

    def is_member?
        if signed_in?
            return current_user.role == "member" ? true : false
        else
            return false
        end
    end

    def is_moderator?
        if signed_in?
            return current_user.role == "moderator" ? true : false
        else
            return false
        end
    end

    def is_admin?
        if signed_in?
            return current_user.role == "superadmin" ? true : false
        else
            return false
        end
    end

    def total_night(c_in, c_out)
        days = c_out.to_date - c_in.to_date
        days = days.to_s.split('/')
        days[0].to_i
    end

    def total_price(c_in, c_out, price)
        total_night(c_in, c_out) * price
    end

    def availability_calendar(date, bookings)
        bookings.each do |b|
            if b.check_in <= date && date <= b.check_out
                return false
            end
        end
        true
    end

end