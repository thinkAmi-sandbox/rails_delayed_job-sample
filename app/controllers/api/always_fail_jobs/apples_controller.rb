class Api::AlwaysFailJobs::ApplesController < ApplicationController
  def create
    AlwaysFailJob.perform_later

    render json: { status: params[:name] }
  end
end