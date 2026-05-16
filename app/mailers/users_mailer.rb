class UsersMailer < ApplicationMailer
  def invite(user)
    @user = user
    mail subject: "You've been invited to Ta3alam", to: user.email_address
  end
end
