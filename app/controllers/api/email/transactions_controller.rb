class Api::Email::TransactionsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      HelloWorldMailer.with(name: params[:name]).welcome_email.deliver_later

      Apple.create(name: params[:name])

      DefaultQueueJob.perform_later(params[:name])

      raise ActiveRecord::Rollback
    end

    render json: { status: params[:name] }
  end
end