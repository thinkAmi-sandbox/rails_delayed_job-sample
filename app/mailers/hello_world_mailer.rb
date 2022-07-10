class HelloWorldMailer < ApplicationMailer
  def welcome_email
    @name = params[:name]
    mail(to: 'bar@example.com', subject: 'Hello, world!')
  end
end
