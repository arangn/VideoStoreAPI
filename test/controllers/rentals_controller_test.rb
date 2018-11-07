require "test_helper"

describe RentalsController do
  RENTAL_FIELDS = %w(check_in_date check_out_date due_date movie_id customer_id).sort

  def check_response(expected_type:, expected_status: :success)
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do

    it "is a real working route" do
      get rentals_path
      body = check_response(expected_type: Array)
      expect(body.length).must_equal Rental.count

      body.each do |rental|
        expect(rental.keys.sort).must_equal RENTAL_FIELDS
      end
    end

    it "returns an empty array when there are no rentals" do

      Rental.destroy_all

      get rentals_path
      body = check_response(expected_type: Array)
      expect(body).must_equal []

    end
  end

  describe 'show' do

    it "retrieves info on one rental" do
      #arrange
      rental = Rental.first
      #act
      get rental_path(rental)
      #assert
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal RENTAL_FIELDS
    end
    it "does something when the rental DNE" do
      #arrange
      rental = Rental.first
      rental.destroy

      #act
      get rental_path(rental)

      #assert
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"
    end
  end

  describe "create method" do
    let(:rental_data) {
      {
        check_out_date: "Wed, 29 Apr 2015 07:54:14 -0700",
        check_in_date: "Wed, 6 May 2015 07:54:14 -0700",
        due_date: "Wed, 6 May 2015 07:54:14 -0700",
        customer_id: customers(:one).id,
        movie_id: movies(:one).id
      }
    }

    it "creates a new rental given valid data" do
      expect {
        post rentals_path, params: {rental: rental_data}
      }.must_change "Rental.count"

      body = check_response(expected_type: Hash)
      rental = Rental.find(body["id"].to_i)
      expect(rental.movie_id).must_equal rental_data[:movie_id]
    end

    it "returns an error for invalid rental data" do
      rental_data["check_out_date"] = nil
      # binding.pry
      expect {
        post rentals_path, params: {rental: rental_data}
      }.wont_change "Rental.count"
      body = check_response(expected_type: Hash)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "check_out_date"
      must_respond_with :bad_request
    end
    # # it "decrements one movie from available inventory" do
    # #   expect {
    # #     post rentals_path, params: {rental: rental_data}
    # #   }.must_change "Rental.count"
    # #   body = check_response(expected_type: Hash)
    # #   rental = Rental.find(body["id"].to_i)
    # #   movie = rental.movie_id
    # #   movie = Movie.find(movie)
    # #   expect(Movie.available_inventory).must_change "available_inventory.count", -1
    # # end
  end

#   describe "movie" do
#     before do
#       @rental_data =
#         {
#           check_out_date: "Wed, 29 Apr 2015 07:54:14 -0700",
#           check_in_date: "Wed, 6 May 2015 07:54:14 -0700",
#           due_date: "Wed, 6 May 2015 07:54:14 -0700",
#           customer_id: customers(:one).id,
#           movie_id: movies(:one).id
#         }
#
#       post rentals_path, params: {@rental_data}
#       body = check_response(expected_type: Hash)
#       rental = Rental.find(body["id"].to_i)
#       movie = rental.movie_id
#       @movie = Movie.find(movie)
#     end
#
#     it "decrements one movie from available inventory" do
#       expect(@movie.available_inventory).must_change "Movie.available_inventory.count", -1
#     end
#     # expect do
#     #   post rentals_path, params: {rental: rental_data}
#     #   body = check_response(expected_type: Hash)
#     #   rental = Rental.find(body["id"].to_i)
#     #   movie = rental.movie_id
#     #   @movie = Movie.find(movie)
#     # end.to_change(@movie.available_inventory, :count).by(-1)
#   end
end
