class ApplicationController < ActionController::Metal
  abstract!

  include AbstractController::Callbacks
  include ActionController::RackDelegation
  include ActionController::StrongParameters
  include ActionController::Rescue

  include Rendering
  include Authentication
  include Serializer

  rescue_from ActionController::ParameterMissing do |expection|
    render json: ResponseError.new([expection.message]), status: 400
  end

  rescue_from Unauthorized do |expection|
    render json: ResponseError.new([expection.message]), status: 401
  end

end
