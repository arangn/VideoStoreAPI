class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: jsonify(customers)

  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render json: jsonify(customer)
    else
      # head :not_found
      render json: { errors: { customer_id: ["No such customer"] }}, status: :not_found
      # render json: {}, status: :not_found
    end
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: {id: customer.id}
    else
      render_error(:bad_request, customer.errors.messages)
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end

  def jsonify(customer)
    return customer.as_json(only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone])
  end
end
