class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :set_current_user
  around_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def set_locale(&action)
      locale = Current.user&.locale || I18n.default_locale
      I18n.with_locale(locale, &action)
    end

    def set_current_user
      @user = Current.user
    end

    def pundit_user
      Current.user
    end

    def user_not_authorized
      flash[:alert] = t("flash.unauthorized")
      redirect_back_or_to(root_path)
    end
end
