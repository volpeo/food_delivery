require "csv"
require_relative "../models/employee"

class EmployeesRepository

  def initialize(csv_path)
    @csv_path = csv_path
    @employees = []
    @next_id = 0
    load_csv
  end

  def add(employee)
    employee.id = @next_id
    @employees << employee
    @next_id += 1
    write_csv
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_login(login)
    @employees.find { |employee| employee.login == login }
  end

  def all
    @employees
  end

  def all_delivery_guys
    @employees.select { |employee| employee.job == :delivery_guy }
  end

  private

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, options) do |row|
      employee = Employee.new(row)
      @employees << employee
      @next_id = employee.id
    end
    @next_id += 1
  end

  def write_csv
    CSV.open(@csv_path, "w") do |csv|
      csv << ["id", "login", "password", "job"]
      @employees.each do |employee|
        csv << [employee.id, employee.login, employee.password, employee.job]
      end
    end
  end

end
