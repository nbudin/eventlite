class ApplicationMailer < ActionMailer::Base
  default from: "Occultopus Productions <contact@#{ENV["SITE_DOMAIN"]}>"
  layout 'mailer'
end
