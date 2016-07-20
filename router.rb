class Router

  def initialize(session_controller, meals_controller, customers_controller, orders_controller)
    @session_controller = session_controller
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
  end

  def run
    loop do
      puts "=========*=*=*= WELCOME TO FOOD DELIVERY =*=*=*=========="
      @employee = @session_controller.sign_in
      while @employee
        if @employee.manager?
          print_menu_manager
          print "choice> "
          choice = gets.chomp.to_i
          print `clear`
          dispatch_manager(choice)
        elsif @employee.delivery_guy?
          print_menu_delivery_guy
          print "choice> "
          choice = gets.chomp.to_i
          print `clear`
          dispatch_delivery_guy(choice)
        end
      end
      puts "Would you like to go home? [Y/N]"
      return if gets.chomp == "Y"
    end
  end

  private

  def print_menu_manager
    puts "------- MANAGER ---------"
    puts "1 - Add a meal"
    puts "2 - View all meals"
    puts "3 - Add a customer"
    puts "4 - View all customers"
    puts "5 - Add an order"
    puts "6 - View all orders"
    puts "7 - View all undelivered orders"
    puts "8 - Exit"
  end

  def print_menu_delivery_guy
    puts "------- DELIVERY GUY ---------"
    puts "1 - View my orders"
    puts "2 - Mark order as delivered"
    puts "3 - Exit"
  end

  def dispatch_manager(choice)
    case choice
    when 1 then @meals_controller.add_a_meal
    when 2 then @meals_controller.fetch_and_print_all_meals
    when 3 then @customers_controller.add_a_customer
    when 4 then @customers_controller.fetch_and_print_all_customers
    when 5 then @orders_controller.add_an_order
    when 6 then @orders_controller.fetch_and_print_all_orders
    when 7 then @orders_controller.fetch_and_print_all_undelivered_orders
    when 8 then @employee = nil
    end
  end

  def dispatch_delivery_guy(choice)
    case choice
    when 1 then @orders_controller.view_my_orders(@employee)
    when 2 then @orders_controller.mark_order_as_delivered(@employee)
    when 3 then @employee = nil
    end
  end

end