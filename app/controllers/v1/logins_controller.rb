class V1::LoginsController < ApplicationController
  before_action :authenticate!, except: [:create]

  def show
    render json: serialize(current_login), status: 200
  end

  def create
    @login = Login.new(login_params)

    if @login.save
      render json: serialize(@login), status: 201
    else
      render json: ResponseError.new(@login), status: 400
    end
  end

  def destroy
    current_login.destroy

    head 204
  end

  private

  def login_params
    params.require(:login)
          .permit(:email, :password)
  end
end
