require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customers_repository)
    @customers_repository = customers_repository
    @customers_view = CustomersView.new
  end

  def add_a_customer
    name = @customers_view.ask_for_name
    address = @customers_view.ask_for_address
    new_customer = Customer.new({ name: name, address: address })
    @customers_repository.add(new_customer)
  end

  def fetch_and_print_all_customers
    customers = @customers_repository.all
    @customers_view.print_all_customers(customers)
  end
end