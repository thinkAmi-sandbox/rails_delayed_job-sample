class Api::ParentChild::StarkingsController < ApplicationController
  def create
    ParentJob.perform_later(params[:prefix])

    render json: { status: params[:prefix]}
  end
end