class V1::SessionsController < ApplicationController
  before_action :authenticate!, except: [:create]

  def show
  end

  def create
    @login = Login.find_by(email: session_params[:email])

    raise Unauthorized unless @login
    raise Unauthorized unless @login.valid_password?(session_params[:password])

    token = AuthToken.encode(id: @login.id)
    session = @login.sessions.create(token: token)

    if session
      render json: serialize(session), status: 201
    else
      raise Unauthorized
    end
  end

  def destroy
  end

  private

  def session_params
    params.require(:session)
          .permit(:email, :password)
  end

end
