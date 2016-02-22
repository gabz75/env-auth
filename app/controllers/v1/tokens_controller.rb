class V1::TokensController < ApplicationController
  before_action :authenticate!, except: [:create]

  def create
    jwt_token = AuthToken.encode(id: valid_account.id)
    token = valid_account.tokens.create(token: jwt_token)

    render json: serialize_model(token), status: 201
  end

  private

  def valid_account
    account = Account.find_by(email: account_params[:email])
    fail Unauthorized unless  account
    fail Unauthorized unless account.valid_password?(account_params[:password])
    account
  end

  def account_params
    params.require(:account)
          .permit(:email, :password)
  end

end
