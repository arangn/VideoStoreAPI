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
    if rental.save
      render json: {id: rental.id}
    else
      render_error(:bad_request, rental.errors.messages)
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:check_in_date, :check_out_date, :due_date)
  end

  def jsonify(rental)
    return rental.as_json(only: [:check_in_date, :check_out_date, :due_date])
  end
end
