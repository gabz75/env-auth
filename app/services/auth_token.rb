module AuthToken

  def self.encode(payload, ttl_in_minutes = 60 * 24 * 30)
    payload[:exp] = ttl_in_minutes.minutes.from_now.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end


  def self.decode(token)
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)
    HashWithIndifferentAccess.new(decoded[0])
  rescue JWT::ExpiredSignature
      raise Unauthorized
  rescue JWT::VerificationError, JWT::DecodeError
      raise Unauthorized
  end
end
