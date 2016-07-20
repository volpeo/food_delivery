class SessionView
  def ask_for_login
    print "login> "
    gets.chomp
  end

  def ask_for_password
    print "password> "
    gets.chomp
  end

  def print_credentials_error
    puts "Bad credentials, try again..."
  end
end