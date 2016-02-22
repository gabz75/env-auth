class V1::AccountsController < ApplicationController
  before_action :authenticate!, except: [:create]

  def show
    render json: serialize_model(current_account), status: 200
  end

  def create
    account = Account.new(account_params)

    if account.save
      render json: serialize_model(account), status: 201
    else
      render json: serialize_model_errors(account), status: 400
    end
  end

  def destroy
    current_account.destroy

    head 204
  end

  private

  def account_params
    params.require(:account)
          .permit(:email, :password)
  end
end
