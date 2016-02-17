module Rendering
  extend ActiveSupport::Concern

  def render(options = {})
    self.status = options[:status] || 200
    self.content_type = 'application/json'
    body = Oj.dump(options[:json], mode: :compat)
    self.headers['Content-Length'] = body.bytesize.to_s
    self.response_body = body
  end

  def head(status)
    self.status = status || 204
    self.content_type = 'application/json'
    self.headers['Content-Length'] = 0
    self.response_body = ''
  end

end
