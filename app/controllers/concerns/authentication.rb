module Authentication
  extend ActiveSupport::Concern

  def authenticate!
    fail Unauthorized unless valid_authenticated_request?
    @current_account = Account.find(jwt_payload[:id])
  end

  def current_account
    @current_account
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
  rescue JWT::ExpiredSignature
      fail Unauthorized
  rescue JWT::VerificationError, JWT::DecodeError
      fail Unauthorized
  end
end
