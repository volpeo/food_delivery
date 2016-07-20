require_relative "../views/meals_view"
require_relative "../models/meal"

class MealsController

  def initialize(meals_repository)
    @meals_view = MealsView.new
    @meals_repository = meals_repository
  end

  def add_a_meal
    name = @meals_view.ask_for_name
    price = @meals_view.ask_for_price
    new_meal = Meal.new({ name: name, price: price })
    @meals_repository.add(new_meal)
  end

  def fetch_and_print_all_meals
    meals = @meals_repository.all
    @meals_view.print_all_meals(meals)
  end
end