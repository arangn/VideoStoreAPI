require "test_helper"

describe MoviesController do
  MOVIE_FIELDS = %w(id title overview release_date inventory).sort

  def check_response(expected_type:, expected_status: :success)
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do

    it "is a real working route" do
      get movies_path
      body = check_response(expected_type: Array)
      expect(body.length).must_equal Movie.count

      body.each do |movie|
        expect(movie.keys.sort).must_equal MOVIE_FIELDS
      end
    end

    it "returns an empty array when there are no movies" do

      Movie.destroy_all

      get movies_path
      body = check_response(expected_type: Array)
      expect(body).must_equal []

    end
  end

  describe 'show' do

    it "retrieves info on one movie" do
      #arrange
      movie = Movie.first
      #act
      get movie_path(movie)
      #assert
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end
    it "does something when the movie DNE" do
      #arrange
      movie = Movie.first
      movie.destroy

      #act
      get movie_path(movie)

      #assert
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"
    end
  end

  describe "create method" do
    let(:movie_data) {
      {
        title: "Idk",
        overview: "string",
        release_date: "2018-9-9",
        inventory: 3
      }
    }

    it "creates a new movie given valid data" do
      expect {
        post movies_path, params: movie_data
      }.must_change "Movie.count"

      body = check_response(expected_type: Hash)
      movie = Movie.find(body["id"].to_i)
      expect(movie.title).must_equal movie_data[:title]
    end

    it "returns an error for invalid movie data" do
      movie_data["title"] = nil
      # binding.pry
      expect {
        post movies_path, params: movie_data
      }.wont_change "Movie.count"
      body = check_response(expected_type: Hash)
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
