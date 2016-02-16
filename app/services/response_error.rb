class ResponseError

  def initialize(resource)
    @resource = resource
    if @resource.respond_to?(:errors)
      @errors = @resource.errors
    else
      @errors = @resource
    end
  end

  def to_json
    { errors: @errors }
  end

end
