class SettingsController < ApplicationController
  def update_locale
    locale = params[:locale].to_s
    if I18n.available_locales.map(&:to_s).include?(locale)
      if Current.user.update(locale: locale)
        redirect_back fallback_location: root_path, notice: t("flash.locale_updated")
      else
        redirect_back fallback_location: root_path, alert: "Could not update language"
      end
    else
      redirect_back fallback_location: root_path, alert: "Invalid language"
    end
  end
end
