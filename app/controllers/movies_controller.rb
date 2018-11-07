class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: jsonify(movies)
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: jsonify(movie)
    else
      # head :not_found
      render json: { errors: { movie_id: ["No such movie"] }}, status: :not_found
      # render json: {}, status: :not_found
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: {id: movie.id}
    else
      render_error(:bad_request, movie.errors.messages)
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end

  def jsonify(movie)
    return movie.as_json(only: [:id, :title, :overview, :release_date, :inventory, :available_inventory])
  end
end
