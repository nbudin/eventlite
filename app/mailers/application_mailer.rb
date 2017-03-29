class ApplicationMailer < ActionMailer::Base
  default from: "info@#{ENV["SITE_DOMAIN"]}"
  layout 'mailer'
end
