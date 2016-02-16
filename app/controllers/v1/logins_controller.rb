class V1::LoginsController < ApplicationController
  before_action :authenticate!, except: [:create]

  def show
    render current_login, status: :ok
  end

  def create
    @login = Login.new(login_params)

    if @login.save
      render @login, status: :created
    else
      render ResponseError.new(@login), status: :unprocessable_entity
    end
  end

  def destroy
    current_login.destroy

    head :no_content
  end

  private

  def login_params
    params.require(:login)
          .permit(:email, :password)
  end
end
