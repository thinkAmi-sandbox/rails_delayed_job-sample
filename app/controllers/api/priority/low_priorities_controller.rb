class Api::Priority::LowPrioritiesController < ApplicationController
  def create
    LowPriorityJob.perform_later

    render json: { status: params[:name]}
  end
end