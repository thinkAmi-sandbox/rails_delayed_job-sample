class Api::Priority::HighPrioritiesController < ApplicationController
  def create
    HighPriorityJob.perform_later

    render json: { status: params[:name]}
  end
end