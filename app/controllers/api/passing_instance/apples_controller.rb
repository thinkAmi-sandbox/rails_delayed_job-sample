class Api::PassingInstance::ApplesController < ApplicationController
  def create
    apple = Apple.new(name: params[:name])
    apple.save

    AppleInstanceJob.perform_later(apple)

    render json: { status: params[:name]}
  end
end