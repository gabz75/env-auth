class ApplicationController < ActionController::Metal
  abstract!

  include AbstractController::Callbacks
  include ActionController::RackDelegation
  include ActionController::StrongParameters
  include ActionController::Rescue

  rescue_from ActionController::ParameterMissing do |expection|
    render json: ResponseError.new([expection.message]), status: 400
  end

  rescue_from Unauthorized do |expection|
    render json: ResponseError.new([expection.message]), status: 401
  end

  def authenticate!
    raise Unauthorized.new('authentication required') unless current_login
  end

  def current_login
    @current_login
  end

  private

  def set_current_login(login)
    @current_login = login
  end

  def authenticate_app!
    authenticate_or_request_with_http_token do |token, _|
      session = Session.find_by(token: token)
      set_current_login(session.login) unless session
    end
  end

  protected

  def serialize(resource)
    JSONAPI::Serializer.serialize(resource)
  end

  private

  def render(options={})
    self.status = options[:status] || 200
    self.content_type = 'application/json'
    body = Oj.dump(options[:json], mode: :compat)
    self.headers['Content-Length'] = body.bytesize.to_s
    self.response_body = body
  end

  ActiveSupport.run_load_hooks(:action_controller, self)
end
