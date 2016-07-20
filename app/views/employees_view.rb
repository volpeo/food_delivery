class EmployeesView

  def print_all_delivery_guys(delivery_guys)
    delivery_guys.each do |delivery_guy|
      puts "#{delivery_guy.id} - #{delivery_guy.login}"
    end
  end

  def ask_for_delivery_guy
    print "delivery guy> "
    gets.chomp.to_i
  end

end