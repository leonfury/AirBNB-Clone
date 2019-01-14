class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper_method :c_user_id
  helper_method :user_name
  helper_method :local_time
  helper_method :is_member?
  helper_method :is_moderator?
  helper_method :is_admin?
  

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
end