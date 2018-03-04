class GenericModel
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def method_missing(method)
    # Light metaprogramming to define methods corresponding to model attributes
    @attributes[method.to_s]
  end
end
