module ControllersHelper
  module ClassMethods
  end

  module InstanceMethods
    def header(key, value)
      request.headers[key] = value
    end

    def authenticate_request!(token)
      request.headers['HTTP_AUTHORIZATION'] = "Bearer #{ token }"
    end

    def json
      @json ||= JSON.parse(response.body).with_indifferent_access
    end
  end
end

RSpec.configure do |config|
  config.include ControllersHelper::InstanceMethods, type: :controller
  config.extend ControllersHelper::ClassMethods, type: :controller
end


