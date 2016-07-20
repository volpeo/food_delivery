class MealsView

  def ask_for_name
    print "name> "
    gets.chomp
  end

  def ask_for_price
    print "price> "
    gets.chomp.to_f
  end

  def print_all_meals(meals)
    meals.each do |meal|
      puts "#{meal.id} - #{meal.name} (#{meal.price} €)"
    end
  end

  def ask_for_meal
    print "meal> "
    gets.chomp.to_i
  end
end