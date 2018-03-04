require "spec_helper"
require "generic_model"

describe GenericModel do
  let(:attributes_hash) do
    {
      "name" => "test_name",
      "count" => rand(1..10),
      "some_attribute" => "fake_value"
    }
  end
  let(:model) { GenericModel.new(attributes_hash)}

  it "defines attributes and methods for those attributes" do
    expect(model.attributes).to eq(attributes_hash)

    [:name, :count, :some_attribute].each do |attribute|
      expect(model.send(attribute)).to eq(attributes_hash[attribute.to_s])
    end
  end

  it "returns nil for methods that don't match an attribute" do
    expect(model.fake_attribute).to be nil
  end
end
