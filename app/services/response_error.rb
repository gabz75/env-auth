class ResponseError

  def initialize(resource)
    @resource = resource
  end

  def to_json
    { errors: @resource.errors }
  end

end
