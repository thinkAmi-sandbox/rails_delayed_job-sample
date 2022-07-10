class Api::InstanceMethod::ApplesController < ApplicationController
  def create
    apple = Apple.new(name: params[:name])
    apple.save

    # モデルのインスタンスメソッドをジョブ実行
    apple.delay.post_api

    render json: { status: params[:name]}
  end
end