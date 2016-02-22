module Serializer
  extend ActiveSupport::Concern

  def serialize_model(resource, options = {})
    JSONAPI::Serializer.serialize(resource, options)
  end

  def serialize_collection(resource, options = {})
    options[:is_collection] = true
    JSONAPI::Serializer.serialize(resource, options)
  end

  def serialize_model_errors(resource, options = {})
    { errors: resource.errors.messages }
  end

  def serialize_error(error, options = {})
    { errors: [ error ] }
  end

  def serialize_errors(errors, options = {})
    { errors: errors }
  end

  def serialize(object, options)
    JSONAPI::Serializer.serialize(object, options)
  end

end
