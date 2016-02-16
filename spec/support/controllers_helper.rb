module ControllersHelper
  module ClassMethods
  end

  module InstanceMethods
    def json
      @json ||= JSON.parse(response.body).with_indifferent_access
    end
  end
end

RSpec.configure do |config|
  config.include ControllersHelper::InstanceMethods, type: :controller
  config.extend ControllersHelper::ClassMethods, type: :controller
end


