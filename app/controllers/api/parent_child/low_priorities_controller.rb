class Api::ParentChild::LowPrioritiesController < ApplicationController
  def create
    LowPriorityJob.perform_later(params[:name])

    render json: { status: params[:name]}
  end
end