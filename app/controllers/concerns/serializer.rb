module Serializer
  extend ActiveSupport::Concern

  def serialize(resource)
    JSONAPI::Serializer.serialize(resource)
  end

end
