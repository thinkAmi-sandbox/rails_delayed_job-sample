class Api::QueueName::AnotherQueuesController < ApplicationController
  def create
    AnotherQueueJob.perform_later(params[:name])

    render json: { status: params[:name]}
  end
end