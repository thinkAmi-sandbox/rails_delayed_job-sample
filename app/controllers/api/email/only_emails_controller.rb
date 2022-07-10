class Api::Email::OnlyEmailsController < ApplicationController
  def create
    HelloWorldMailer.with(name: params[:name]).welcome_email.deliver_later

    render json: { status: params[:name] }
  end
end