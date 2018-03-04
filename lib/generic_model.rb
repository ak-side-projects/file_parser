class GenericModel
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def method_missing(method)
    @attributes[method.to_s]
  end
end
