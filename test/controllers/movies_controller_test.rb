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
    it "can create a movie" do
      movie_params = {
      movie: {
        title: "Movie",
        overview: 2018-01-01,
        release_date: "words words words",
        inventory: 3
      }}
      post movies_path(params: movie_params)
      body = check_response(expected_type: Hash)
    end
  end

end
