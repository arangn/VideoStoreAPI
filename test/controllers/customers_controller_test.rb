require "test_helper"
require "pry"

describe CustomersController do
  CUSTOMER_FIELDS = %w(id name registered_at address city state postal_code phone).sort

  # Helper method to dry code
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "retrieves all the customers" do
      get customers_path

      body = check_response(expected_type: Array)

      expect(body.length).must_equal Customer.count

      body.each do |customer|
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end

    it "returns an empty array when there are no customers" do
      # Arrange
      Customer.destroy_all

      # Act
      get customers_path

      # Assert
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end

  end

  describe "show" do
    it "retrieves info on one customer" do
      # Arrange
      customer = Customer.first

      # Act
      get customer_path(customer)

      # Assert
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal CUSTOMER_FIELDS
    end

    it "sends back not_found when the pet DNE" do
      # Arrange
      customer = Customer.first
      customer.destroy

      # Act
      get customer_path(customer)

      # Assert
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"
    end

    describe "create" do
      let(:customer_hash) {

        {
          name: 'Disco Tech',
          registered_at: 'Wed, 29 Apr 2015 07:54:14 -0700',
          address: '11 Main St',
          city: 'Seattle',
          state: 'WA',
          postal_code: '12345',
          phone: '222-222-4444'
        }
      }

      it "can create a customer" do

        expect {
          post customers_path, params: { customer: customer_hash }
        }.must_change 'Customer.count', 1

        body = check_response(expected_type: Hash)
        customer = Customer.find(body["id"].to_i)

        expect(customer.name).must_equal customer_hash[:name]

      end

      it "returns an error for invalid customer data" do

        customer_hash["name"] = nil

        expect {
          post customers_path, params: { customer: customer_hash }
        }.wont_change "Customer.count"

        body = JSON.parse(response.body)

        expect(body).must_be_kind_of Hash
        expect(body).must_include "errors"
        expect(body["errors"]).must_include "name"
        must_respond_with :bad_request

      end

    end

  end
end
