class Api::Email::DeliverOptionsController < ApplicationController
  def create
    HelloWorldMailer.with(name: params[:name]).welcome_email.deliver_later(
      queue: 'override_queue',
      priority: 45
    )

    render json: { status: params[:name] }
  end
end