class BaseSerializer
  include JSONAPI::Serializer

  def id
    object.id.to_s
  end

end
