class OrdersView

  def print_all_orders(orders)
    orders.each do |order|
      status = order.delivered? ? "DELIVERED" : "IN TRANSIT"
      puts "------------------V #{status} V-----------------"
      puts "Order ##{order.id} - #{Date.parse(order.date).strftime("%d/%m/%Y")}"
      puts "Client: #{order.customer.name} - #{order.customer.address}"
      puts "Delivered by: #{order.employee.login}"
      puts "Meal: #{order.meal.name} (#{order.meal.price} €)"
    end
  end

  def ask_for_order
    print "order> "
    gets.chomp.to_i
  end
end