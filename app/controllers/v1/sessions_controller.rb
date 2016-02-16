class V1::SessionsController < ApplicationController
  before_action :authenticate!, except: [:create]
  before_action :find_login, only: [:create]

  def show
  end

  def create
    unless current_login
      return render json: { errors: 'unauthenticated' }, status: 400
    end

    if (new_session = current_login.sessions.create)
      render json: new_session, status: 201
    else
      render json: ResponseError.new(new_session), status: 400
    end
  end

  def destroy
  end

  private

  def find_login
    login = Login.find_by!(
      email: session_params[:email],
      password: session_params[:password]
    )

    set_current_login(login)
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
