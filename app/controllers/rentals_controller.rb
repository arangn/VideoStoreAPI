class RentalsController < ApplicationController
  def index
    rentals = Rental.all
    render json: jsonify(rentals)
  end

  def show
    rental = Rental.find_by(id: params[:id])
    if rental
      render json: jsonify(rental)
    else
      # head :not_found
      render json: { errors: { rental_id: ["No such rental"] }}, status: :not_found
      # render json: {}, status: :not_found
    end
  end

  def create
    rental = Rental.new(rental_params)
    movie = Movie.find_by(id: rental_params[:movie_id])
    # binding.pry
    customer = Customer.find_by(id: rental_params[:customer_id])
    if rental.movie.available_inventory == 0
      # binding.pry
      render json: { errors: { rental_id: ["No available inventory"] }}, status: :bad_request
    else
      rental.check_out_date = DateTime.now
      rental.due_date = DateTime.now + 1.week
      if rental.save
        rental.check_out_movie(customer, movie)
        render json: jsonify(rental.movie.available_inventory)
      else
        render_error(:bad_request, rental.errors.messages)
      end
    end
  end

  def check_in
    rental = Rental.find_by(rental_params)
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])
    if rental
      rental.check_in_date = DateTime.now
      rental.check_in_movie(customer, movie)
      if rental.save
        render json: jsonify(rental.movie.available_inventory)
      else
        render json: { errors: { rental_id: ["No such rental"] }}, status: :bad_request
      end
    end
  end

  # def self.check_out
  #   rental = Rental.new(rental_params)
  #   rental.check_out_date = DateTime.now
  #   rental.due_date = DateTime.now + 1.week
  #   if rental.save
  #     render json: jsonify(rental)
  #   else
  #     render_error(:bad_request, rental.errors.messages)
  #   end
  # end
  #
  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end

  def jsonify(rental)
    return rental.as_json(only: [:id, :check_in_date, :check_out_date, :due_date, :movie_id, :customer_id])
  end
end
