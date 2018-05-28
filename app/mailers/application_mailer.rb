class ApplicationMailer < ActionMailer::Base
  default from: 'default@mail.com'
  layout 'mailer'
end