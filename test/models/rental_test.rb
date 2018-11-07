require "test_helper"

describe Rental do
  # let(:rental_data) { rentals(:one) }
  # let(:elf) { movies(:two) }
  # let(:petunia_picklepants) { customers(:three) }
#
#   {
#     {
#     check_out_date: "Wed, 29 Apr 2015 07:54:14 -0700",
#     check_in_date: "Wed, 6 May 2015 07:54:14 -0700",
#     due_date:" Wed, 6 May 2015 07:54:14 -0700",
#     movie_id: movies(:one).id,
#     customer_id: customers(:one).id
#   }
# }

  it "must be valid" do
    customer = Customer.first
    movie = Movie.first
    rental = Rental.new(customer_id = customer.id, movie_id = movie.id, check_in_date = "Wed, 6 May 2015 07:54:14 -0700", check_out_date = "Wed, 29 Apr 2015 07:54:14 -0700", due_date = " Wed, 6 May 2015 07:54:14 -0700")

    rental.must_be :valid?
  end

  it "requires movie id, customer id, due date, check out date"do
  required_fields = [:movie_id, :customer_id, :due_date, :check_out_date]

    required_fields.each do |field|
      one[field] = nil

      expect(one.valid?).must_equal false

      one.reload
    end

  end

  it "calculates due date" do
  end

  it "checkout date must be after check_in_date" do
  end

  it "assigins overdue status based on due_date and check_in_date" do
  end

  describe "relations" do

    it 'belongs to a movie' do

      expect()
    end

    it 'belongs to a customer' do
    end
  end




end
