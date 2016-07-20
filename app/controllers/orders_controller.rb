require_relative "../views/orders_view"
require_relative "../views/customers_view"
require_relative "../views/employees_view"
require_relative "../models/order"

class OrdersController
  def initialize(orders_repository, customers_repository, employees_repository, meals_repository)
    @orders_repository = orders_repository
    @customers_repository = customers_repository
    @employees_repository = employees_repository
    @meals_repository = meals_repository

    @orders_view = OrdersView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
    @meals_view = MealsView.new
  end

  def add_an_order
    customers = @customers_repository.all
    @customers_view.print_all_customers(customers)
    customer_id = @customers_view.ask_for_customer
    customer = @customers_repository.find(customer_id)

    delivery_guys = @employees_repository.all_delivery_guys
    @employees_view.print_all_delivery_guys(delivery_guys)
    delivery_guy_id = @employees_view.ask_for_delivery_guy
    delivery_guy = @employees_repository.find(delivery_guy_id)

    meals = @meals_repository.all
    @meals_view.print_all_meals(meals)
    meal_id = @meals_view.ask_for_meal
    meal = @meals_repository.find(meal_id)

    new_order = Order.new(customer: customer, meal: meal, employee: delivery_guy)
    @orders_repository.add(new_order)
  end

  def fetch_and_print_all_orders
    orders = @orders_repository.all
    @orders_view.print_all_orders(orders)
  end

  def fetch_and_print_all_undelivered_orders
    undelivered_orders = @orders_repository.all_undelivered
    @orders_view.print_all_orders(undelivered_orders)
  end

  def view_my_orders(employee)
    my_undelivered_orders = @orders_repository.all_my_undelivered(employee)
    @orders_view.print_all_orders(my_undelivered_orders)
  end

  def mark_order_as_delivered(employee)
    my_undelivered_orders = @orders_repository.all_my_undelivered(employee)
    @orders_view.print_all_orders(my_undelivered_orders)

    order_id = @orders_view.ask_for_order
    order = @orders_repository.find(order_id)
    order.mark_as_delivered!
    @orders_repository.write_csv
  end
end