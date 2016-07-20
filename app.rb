require_relative "router"

require_relative "app/controllers/session_controller"
require_relative "app/controllers/meals_controller"
require_relative "app/controllers/customers_controller"
require_relative "app/controllers/orders_controller"

require_relative "app/repositories/employees_repository"
require_relative "app/repositories/meals_repository"
require_relative "app/repositories/customers_repository"
require_relative "app/repositories/orders_repository"

def path_for_csv(name)
  File.join(File.dirname(__FILE__), "data/#{name}.csv")
end

employees_repository = EmployeesRepository.new(path_for_csv("employees"))
meals_repository = MealsRepository.new(path_for_csv("meals"))
customers_repository = CustomersRepository.new(path_for_csv("customers"))
orders_repository = OrdersRepository.new(path_for_csv("orders"),
                                         customers_repository,
                                         meals_repository,
                                         employees_repository)

session_controller = SessionController.new(employees_repository)
meals_controller = MealsController.new(meals_repository)
customers_controller = CustomersController.new(customers_repository)
orders_controller = OrdersController.new(orders_repository,
                                         customers_repository,
                                         employees_repository,
                                         meals_repository)

Router.new(session_controller,
           meals_controller,
           customers_controller,
           orders_controller).run

