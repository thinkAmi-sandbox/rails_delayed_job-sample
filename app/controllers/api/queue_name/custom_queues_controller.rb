class Api::QueueName::CustomQueuesController < ApplicationController
  def create
    CustomQueueJob.perform_later(params[:name])

    render json: { status: params[:name]}
  end
end