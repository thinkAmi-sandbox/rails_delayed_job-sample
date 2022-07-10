class Api::QueueName::DefaultQueuesController < ApplicationController
  def create
    DefaultQueueJob.perform_later(params[:name])

    render json: { status: params[:name]}
  end
end