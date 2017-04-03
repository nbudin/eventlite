class ApplicationMailer < ActionMailer::Base
  default from: "contact@#{ENV["SITE_DOMAIN"]}"
  layout 'mailer'
end
