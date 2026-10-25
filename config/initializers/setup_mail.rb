# if Rails.env.development? || Rails.env.staging? || Rails.env.production?
if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '587',
    authentication: :plain,
    user_name: ENV.fetch('SENDGRID_USERNAME', nil),
    password: ENV.fetch('SENDGRID_PASSWORD', nil),
    domain: 'heroku.com',
    enable_starttls_auto: true
  }
end
