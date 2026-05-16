class UsersMailer < ApplicationMailer
  def invite(user)
    @user = user
    I18n.with_locale(user.locale) do
      mail subject: t("mailers.users.invite.subject"), to: user.email_address
    end
  end
end
