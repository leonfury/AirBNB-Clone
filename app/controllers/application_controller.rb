class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper_method :user_id
  helper_method :user_name
  helper_method :local_time

  def user_id
    current_user.id
  end

  def user_name
    current_user.first_name
  end

  def local_time(date)
    z = date + 28800
    z.to_date
  end
end
