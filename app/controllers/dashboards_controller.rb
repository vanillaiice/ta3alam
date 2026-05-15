class DashboardsController < ApplicationController
  layout "dashboard"
  before_action :set_user

  def show
    case Current.user.role
    when "student"
      redirect_to [ :klasses ]
    when "owner", "teacher"
      redirect_to [ :courses ]
    else
      redirect_to new_session_path, alert: "Unauthorized"
    end
  end

  # def show
  #  case Current.user.role
  #  when "owner"
  #    render "dashboards/owner"
  #  when "teacher"
  #    render "dashboards/teacher"
  #  when "student"
  #    render "dashboards/student"
  #  else
  #    redirect_to root_path, alert: "Unauthorized"
  #  end
  # end

  private
    def set_user
      @user = Current.user
    end
end
