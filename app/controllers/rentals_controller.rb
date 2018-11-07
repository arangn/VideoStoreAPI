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
    if rental.movie.available_inventory == 0
      # binding.pry
      render json: { errors: { rental_id: ["No available inventory"] }}, status: :bad_request
    else
      rental.check_out_date = DateTime.now
      rental.due_date = DateTime.now + 1.week
      if rental.save
        rental.movie.available_inventory = rental.movie.available_inventory - 1
        # binding.pry
        render json: jsonify(rental)
      else
        render_error(:bad_request, rental.errors.messages)
      end
    end
  end

  # def check_in
  #   rental = Rental.find_by(id: params[:id])
  #   rental.check_in_date = DateTime.now
  #
  # end

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
