class CustomersView
  def ask_for_name
    print "name> "
    gets.chomp
  end

  def ask_for_address
    print "address> "
    gets.chomp
  end

  def print_all_customers(customers)
    customers.each do |customer|
      puts "#{customer.id} - #{customer.name} (#{customer.address})"
    end
  end

  def ask_for_customer
    print "customer> "
    gets.chomp.to_i
  end
end