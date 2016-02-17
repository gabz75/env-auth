module Authentication
  extend ActiveSupport::Concern

  def authenticate!
    fail Unauthorized unless valid_authenticated_request?
    @current_login = Login.find(jwt_payload[:id])
  end

  def current_login
    @current_login
  end


  def valid_authenticated_request?
    authorization_header && jwt_payload && jwt_payload[:id]
  end

  def authorization_header
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def jwt_payload
    @jwt_payload ||= AuthToken.decode(authorization_header)
  end
end
