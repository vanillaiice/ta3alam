class ApplicationMailer < ActionMailer::Base
  default from: -> { "#{ENV.fetch('SEND_FROM', 'no-reply')}@#{ENV.fetch('MAILER_DOMAIN', 'example.com')}" }
  layout "mailer"
end
