require_relative "../views/session_view"

class SessionController

  def initialize(employees_repository)
    @view = SessionView.new
    @employees_repository = employees_repository
  end

  def sign_in
    loop do
      login = @view.ask_for_login
      password = @view.ask_for_password
      employee = @employees_repository.find_by_login(login)

      if employee && employee.password == password
        return employee
      else
        @view.print_credentials_error
      end
    end
  end
end