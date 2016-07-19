require "csv"
require_relative "../models/meal"

class MealsRepository

  def initialize(csv_path)
    @csv_path = csv_path
    @meals = []
    @next_id = 0
    load_csv
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    write_csv
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def delete(id)
    @meals.delete(find(id))
    write_csv
  end

  def all
    @meals
  end

  private

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, options) do |row|
      meal = Meal.new(row)
      @meals << meal
      @next_id = meal.id
    end
    @next_id += 1
  end

  def write_csv
    CSV.open(@csv_path, "w") do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end

# meals_repo = MealsRepository.new(File.join(File.dirname(__FILE__), "../../data/meals.csv"))

# meals_repo.delete(4)