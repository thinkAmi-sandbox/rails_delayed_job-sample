class Api::PassingOpenStruct::ApplesController < ApplicationController
  def create
    apple = OpenStruct.new(
      {
        id: 1,
        name: params[:name]
      }
    )

    # OpenStruct のままではエラー
    # OpenStructJob.perform_later(apple)
    # => ActiveJob::SerializationError (Unsupported argument type: OpenStruct):
    # https://guides.rubyonrails.org/active_job_basics.html#supported-types-for-arguments

    # ハッシュにすればOK
    OpenStructJob.perform_later(apple.to_h)

    render json: { status: apple.name}
  end
end