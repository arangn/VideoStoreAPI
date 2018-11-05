require "test_helper"

describe Controller do
  let(:controller) { Controller.new }

  it "must be valid" do
    value(controller).must_be :valid?
  end
end
