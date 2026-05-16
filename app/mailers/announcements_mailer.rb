class AnnouncementsMailer < ApplicationMailer
  def notify(user, announcement)
    @user = user
    @announcement = announcement
    @klass = announcement.klass

    I18n.with_locale(user.locale) do
      mail subject: t("mailers.announcements.notify.subject", course: @klass.course.number, code: @klass.code),
           to: user.email_address
    end
  end
end
