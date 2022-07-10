class Api::QueueBackend::AsyncBackendsController < ApplicationController
  def create
    AsyncBackendJob.perform_later

    render json: { status: params[:name]}
  end
end