class AnnouncementsMailer < ApplicationMailer
  def notify(user, announcement)
    @user = user
    @announcement = announcement
    @klass = announcement.klass

    mail subject: "[#{@klass.course.number} - #{@klass.code}] New Announcement",
         to: user.email_address
  end
end
