require "test_helper"

describe Rental do

  let(:rental_data) {
    {
      check_out_date: "Wed, 29 Apr 2015 07:54:14 -0700",
      check_in_date: "Wed, 6 May 2015 07:54:14 -0700",
      due_date:" Wed, 6 May 2015 07:54:14 -0700",
      movie_id: movies(:one).id,
      customer_id: customers(:one).id
    }
  }
  before do
    @rental = Rental.new(rental_data)
    @rental.save
  end

  it "must be valid" do
    # rental = Rental.new(rental_data)

    @rental.must_be :valid?
  end

  it "requires movie id, customer id, due date, check out date" do
    required_fields = [:movie_id, :customer_id, :due_date, :check_out_date]

    required_fields.each do |field|
      @rental[field] = nil

      expect(@rental.valid?).must_equal false

      @rental.reload
    end
  end

  describe "relations" do
    it 'belongs to a movie' do

      expect(@rental).must_respond_to :movie
    end

    it 'belongs to a customer' do
      expect(@rental).must_respond_to :customer
    end
  end




end
