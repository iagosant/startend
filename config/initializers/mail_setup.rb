ActionMailer::Base.smtp_settings = {
:address => 'smtp.sendgrid.net',
:port => 587,
:authentication => :plain,
:user_name => ENV['SENDGRID_USERNAME'],
:password => ENV['SENDGRID_PASSWORD'],
:domain => 'startend.herokuapp.com'
}
ActionMailer::Base.delivery_method = :smtp
