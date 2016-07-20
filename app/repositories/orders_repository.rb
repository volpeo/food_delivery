require "csv"
require_relative "../models/order"
require_relative "../models/meal"
require_relative "../models/customer"
require_relative "../models/employee"
require_relative "employees_repository"
require_relative "customers_repository"
require_relative "meals_repository"

class OrdersRepository

  def initialize(csv_path, customers_repository, meals_repository, employees_repository)
    @csv_path = csv_path
    @customers_repository = customers_repository
    @meals_repository = meals_repository
    @employees_repository = employees_repository
    @orders = []
    @next_id = 0
    load_csv
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    write_csv
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end

  def all
    @orders
  end

  def write_csv
    CSV.open(@csv_path, "w") do |csv|
      csv << ["id", "date", "customer_id", "meal_id", "employee_id", "delivered"]
      @orders.each do |order|
        csv << [order.id, order.date, order.customer.id, order.meal.id, order.employee.id, order.delivered]
      end
    end
  end

  private

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, options) do |row|
      order = Order.new(row)
      order.customer = @customers_repository.find(row[:customer_id].to_i)
      order.meal = @meals_repository.find(row[:meal_id].to_i)
      order.employee = @employees_repository.find(row[:employee_id].to_i)
      @orders << order
      @next_id = order.id
    end
    @next_id += 1
  end
end

# customers_repo = CustomersRepository.new(File.join(File.dirname(__FILE__), "../../data/customers.csv"))
# meals_repo = MealsRepository.new(File.join(File.dirname(__FILE__), "../../data/meals.csv"))
# employees_repo = EmployeesRepository.new(File.join(File.dirname(__FILE__), "../../data/employees.csv"))
# orders_repo = OrdersRepository.new(File.join(File.dirname(__FILE__), "../../data/orders.csv"), customers_repo, meals_repo, employees_repo)

# customer = Customer.new({ name: "Bernard", address: "101 quai des Chartrons" })
# deliv_guy = Employee.new({ login: "charles", password: "456lune", job: :delivery_guy })
# meal = Meal.new({ name: "Burger", price: 12 })

# customers_repo.add(customer)
# meals_repo.add(meal)
# employees_repo.add(deliv_guy)

# order_data = {
#   customer: customer,
#   employee: deliv_guy,
#   meal: meal
# }

# order = Order.new(order_data)

# orders_repo.add(order)

# order.mark_as_delivered!

# orders_repo.write_csv

# p orders_repo.all