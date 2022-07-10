class Api::Rollback::ApplesController < ApplicationController
  def create
    # トランザクションの開始
    ActiveRecord::Base.transaction do

      # モデルの作成
      Apple.create(name: params[:name])

      # キューへの登録
      DefaultQueueJob.perform_later(params[:name])

      # トランザクションロールバックの発生
      raise ActiveRecord::Rollback
    end

    render json: { status: params[:name]}
  end
end