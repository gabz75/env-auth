class ApplicationController < ActionController::Base
  include AbstractController::Rendering
  include ActionController::Rendering
  include ActionController::Renderers::All
  include ActionController::StrongParameters
  include ActionController::ForceSSL
  include ActionController::Instrumentation

  include Serializer
  include Authentication
  # include Rendering

  rescue_from ActionController::ParameterMissing do |expection|
    render json: serialize_error(expection.message), status: 400
  end

  rescue_from ActiveRecord::RecordNotFound do |expection|
    render json: serialize_error(expection.message), status: 404
  end

  rescue_from Unauthorized do |expection|
    render json: serialize_error(expection.message), status: 401
  end

end
